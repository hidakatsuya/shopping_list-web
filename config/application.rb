# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShoppingList
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # ENV['GSM_ENV_SKIP_LOAD']:
    #   This used when loading of secrets is not required, such s when running rake assets:precompile
    #     $ GSM_ENV_SKIP_LOAD=1 bin/rails assets:precompile
    if !ENV['GSM_ENV_SKIP_LOAD'] && defined?(GsmEnv) && Rails.env.production?
      GsmEnv.load(filter: 'labels.role=app') do |secret|
        if secret.name.end_with?('_JSON')
          JSON.parse(secret.value).each { |k, v| ENV[k] = v }
        else
          ENV[secret.name] = secret.value
        end
      end
    end

    config.i18n.available_locales = [:en, :ja]

    # Email addresses to which accounts can be registered. If there is more than one,
    # separate them with a space.
    config.registrable_account_emails = ENV['REGISTRABLE_ACCOUNT_EMAILS']
  end
end
