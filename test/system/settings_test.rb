# frozen_string_literal: true

require 'application_system_test_case'

class SettingsTest < ApplicationSystemTestCase
  setup do
    @logged_user = users(:user_a)
    login_as @logged_user

    visit settings_path
  end

  test 'API token' do
    within id: 'api-token' do
      assert_text 'APIトークン'

      assert_field 'token-value', with: @logged_user.token.value
      assert_button '再生成'
      assert_button '削除'

      Token.stub :generate_token, 'regenerated token' do
        click_on '再生成'
        assert_field 'token-value', with: 'regenerated token'
      end
      assert_button '再生成'
      assert_button '削除'

      click_on '削除'
      assert_field 'token-value', with: ''
      assert_button '生成'
      assert_no_button '再生成'
      assert_no_button '削除'
    end
  end

  test 'sign out' do
    assert_button 'ログアウト'

    click_on 'ログアウト'

    assert_button 'Google でログイン'

    visit settings_path
    assert_button 'Google でログイン'
    assert_text 'ログインもしくはアカウント登録してください。'
  end

  test 'delete account' do
    assert_button 'アカウント削除'
    accept_confirm do
      click_on 'アカウント削除'
    end

    assert_button 'Google でログイン'

    visit settings_path
    assert_button 'Google でログイン'
    assert_text 'ログインもしくはアカウント登録してください。'

    assert_not User.exists?(@logged_user.id)
  end
end
