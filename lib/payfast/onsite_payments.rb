require 'net/http'
require 'uri'

module Payfast
  # Encaspulates the  utils for makeing payfast payments using their onsite feature
  class OnsitePayments
    def self.generate_signature(payload)
      passphrase = Rails.application.config_for(:payfast).passphrase

      payload[:passphrase] = passphrase if passphrase

      url_encoded = data_to_string(payload)
      create_hash(url_encoded, 'md5')
    end

    def self.requestPayment(payload)
      payload_with_config = {
        merchant_id: Rails.application.config_for(:payfast).merchant_id,
        merchant_key: Rails.application.config_for(:payfast).merchant_key,
        return_url: Rails.application.config_for(:payfast).return_url,
        cancel_url: Rails.application.config_for(:payfast).cancel_url,
        notify_url: Rails.application.config_for(:payfast).notify_url
      }.merge(payload)

      puts payload_with_config

      signature = generate_signature(payload_with_config)
      payload_with_config[:signature] = signature

      pf_param_string = data_to_string(payload_with_config)
      base_url = Rails.application.config_for(:payfast).base_url

      puts pf_param_string

      uri = URI.parse(base_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      request = Net::HTTP::Post.new(uri.path)
      request.body = pf_param_string

      begin
        response = http.request(request)
        JSON.parse(response.body)
      rescue StandardError => e
        puts "Error: #{e.message}"
        false
      end
    end

    def self.data_to_string(payload)
      URI.encode_www_form(payload)
    end

    def self.create_hash(data, algorithm)
      digest = Digest.const_get(algorithm.upcase).new
      digest.update(data)
      digest.hexdigest
    end
  end
end
