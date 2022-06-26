# frozen_string_literal: true

require 'test_helper'
require 'playwright_driver'

Capybara.server_host = '0.0.0.0'
Capybara.app_host = "http://#{`hostname`.strip&.downcase || "0.0.0.0"}"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Warden::Test::Helpers

  driven_by :playwright, screen_size: [1400, 1400]
end
