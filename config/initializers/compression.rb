# frozen_string_literal: true

Rails.application.configure do
  # Use environment names or environment variables:
  # break unless Rails.env.production?
  # break unless ENV['ENABLE_COMPRESSION'] == '1'

  # Strip all comments from JavaScript files, even copyright notices.
  # By doing so, you are legally required to acknowledge
  # the use of the software somewhere in your Web site or app:
  # uglifier = Uglifier.new(harmony: true, output: { comments: :none })

  # To keep all comments instead or only keep copyright notices (the default):
  # uglifier = Uglifier.new output: { comments: :all }
  # uglifier = Uglifier.new output: { comments: :copyright }

  config.assets.compile = true
  config.assets.debug = false

  config.assets.js_compressor = :terser
  # config.assets.css_compressor = :sass

  config.middleware.use Rack::Deflater
  config.middleware.use Rack::Brotli
  # config.middleware.insert_before ActionDispatch::Static, Rack::Deflater

  config.middleware.use HtmlCompressor::Rack,
                        # compress_html: true,
                        # compress_css: true,
                        # compress_javascript: true,
                        # css_compressor: Sass,
                        # javascript_compressor: uglifier,
                        # javascript_compressor: Terser,
                        # remove_input_attributes: true,
                        # remove_javascript_protocol: true,
                        # remove_link_attributes: true,
                        # remove_script_attributes: true,
                        # remove_style_attributes: true,
                        enabled: true,
                        preserve_line_breaks: false,
                        remove_comments: true,
                        remove_form_attributes: false,
                        remove_http_protocol: false,
                        remove_https_protocol: false,
                        remove_intertag_spaces: false,
                        remove_multi_spaces: true,
                        remove_quotes: true,
                        simple_boolean_attributes: true,
                        simple_doctype: false
end
