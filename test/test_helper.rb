# frozen_string_literal: true

ENV["RAILS_ENV"] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/mock'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def controller_assigns(varaiable_name)
    @controller.view_assigns[varaiable_name.to_s]
  end

  def omniauth_mock
    OmniAuth.configure do |config|
      config.test_mode = true
      config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '999',
        info: {
          email: 'user@example.com'
        }
      )
    end
  end

  def omniauth_mock_add(extra_auth)
    OmniAuth.config.add_mock(:google_oauth2, extra_auth)
  end

  def omniauth_mock_request_env
    {
      'devise.mapping' => Devise.mappings[:user],
      'omniauth.auth' => OmniAuth.config.mock_auth[:google_oauth2]
    }
  end
end
