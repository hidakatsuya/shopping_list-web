# frozen_string_literal: true

require 'application_system_test_case'

class SettingsTest < ApplicationSystemTestCase
  setup do
    @logged_user = users(:user_a)
    login_as @logged_user
  end

  test 'show' do
    visit settings_path
    assert_text 'APIトークン'
    assert_field 'token-value', with: @logged_user.token.value
  end
end
