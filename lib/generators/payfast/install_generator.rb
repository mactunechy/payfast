require "rails/generators"

module Payfast
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def modify_routes
        insert_into_file "config/routes.rb", after: "Rails.application.routes.draw do\n" do
          # Read and insert the contents of your routes template file
          File.read(File.join(__dir__, "templates", "routes.rb"))
        end
      end

      def create_controller
        template "controller.rb", File.join("app/controllers", "#{controller_file_name}_controller.rb")
      end

      def create_views
        actions.each do |action|
          template "#{action}.html.erb", File.join("app/views", controller_file_name, "#{action}.html.erb")
        end
      end

      def create_view_helper
        template "helper.rb", "app/helpers/carts_helper.rb"
      end

      def create_migration
        template "migration.rb", "db/migrate/#{timestamp}_create_carts.rb"
      end

      def create_config_file
        template "config.yml", "config/payfast.yml"
      end

      def create_model
        template "model.rb", "app/models/cart.rb"
      end

      def add_erb_tag
        # Append an ERB tag to the application.html.erb file
        insert_into_file "app/views/layouts/application.html.erb", before: "</head>" do
          "<%= payfast_script_tag %>"
        end
      end

      def configure_development
        insert_into_file "config/environments/development.rb", before: /^end/ do
          <<-RUBY.strip_heredoc.indent(2)
              config.hosts << /[a-z0-9-]+\.ngrok-free\.app/
          RUBY
        end
      end

      private

      def controller_file_name
        "carts"
      end

      def timestamp
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def actions
        %w(index make_payment)
      end
    end
  end
end
