# frozen_string_literal: true

require 'test_helper'
require 'capybara/cuprite'

Capybara.configure do |config|
  config.server_host = '0.0.0.0'
  config.app_host = "http://#{`hostname`.strip&.downcase || '0.0.0.0'}"
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Warden::Test::Helpers

  driven_by :cuprite, options: {
    url: ENV['CHROME_URL'],
    browser_options: { 'no-sandbox': nil }
  }
end
