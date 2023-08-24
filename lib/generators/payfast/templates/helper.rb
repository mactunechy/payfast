module CartsHelper
  def payfast_script_tag
    script_src = Rails.application.config_for(:payfast).js_bundle
    content_tag(:script, "", src: script_src)
  end
end
