# frozen_string_literal: true

require 'application_system_test_case'

class SettingsTest < ApplicationSystemTestCase
  setup do
    @logged_user = users(:user_a)
    login_as @logged_user

    visit settings_path
  end

  test 'show' do
    assert_text 'APIトークン'
    assert_field 'token-value', with: @logged_user.token.value
  end

  test 'sign out' do
    assert_button 'ログアウト'
    click_on 'ログアウト'

    assert_button 'Googleでログイン'

    visit settings_path
    assert_button 'Googleでログイン'
    assert_text 'ログインもしくはアカウント登録してください。'
  end
end
