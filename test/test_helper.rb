# frozen_string_literal: true

ENV["RAILS_ENV"] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/mock'

OmniAuth.config.test_mode = true

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def controller_assigns(varaiable_name)
    @controller.view_assigns[varaiable_name.to_s]
  end

  def omniauth_mock
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '999',
      info: {
        email: 'user@example.com'
      }
    )
  end

  def omniauth_mock_add(extend_auth)
    OmniAuth.config.add_mock(:google_oauth2, extend_auth)
  end

  def omniauth_mock_request_env
    {
      'devise.mapping' => Devise.mappings[:user],
      'omniauth.auth' => OmniAuth.config.mock_auth[:google_oauth2]
    }
  end

  def registrable_account_emails_stub(*emails, &block)
    value = emails.one? ? emails.first : emails.join(' ')
    Rails.configuration.stub(:registrable_account_emails, value, &block)
  end
end
