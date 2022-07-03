# frozen_string_literal: true

require 'application_system_test_case'

class SettingsTest < ApplicationSystemTestCase
  setup do
    @logged_user = users(:user_a)
    login_as @logged_user

    visit settings_path
  end

  test 'API token' do
    assert_text 'API Token'

    assert_field 'token-value', with: @logged_user.token.value
    assert_button 'Regenerate'
    assert_button 'Delete'
  end

  test 'sign out' do
    click_on 'Sign out'

    assert_button 'Sign in with Google'

    visit settings_path
    assert_button 'Sign in with Google'
    assert_text /You need to sign in or sign up/
  end

  test 'delete account' do
    accept_confirm do
      click_on 'Delete account'
    end

    assert_button 'Sign in with Google'

    visit settings_path
    assert_button 'Sign in with Google'
    assert_text /You need to sign in or sign up/

    assert_not User.exists?(@logged_user.id)
  end
end
