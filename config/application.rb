# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
# require "active_record/railtie"
# require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require 'action_mailbox/engine'
# require "action_text/engine"
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FundusFrontend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Asia/Jakarta'
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Rename the default Rack session cookie
    config.session_store :cookie_store, key: '_fundus.dsc.ui.ac.id_session', domain: :all, tld_length: 2

    # Change Encrypted Cookie
    config.action_dispatch.encrypted_cookie_salt = Rails.application.credentials.encrypted_cookie_salt
    config.action_dispatch.authenticated_encrypted_cookie_salt = Rails.application.credentials.authenticated_encrypted_cookie_salt # rubocop:disable Layout/LineLength

    # Set Secret Key Base
    config.secret_key_base = Rails.application.credentials.secret_key_base

    # Show custom error page if raised
    config.exceptions_app = ->(env) { ErrorsController.action(:show).call(env) }
  end
end
