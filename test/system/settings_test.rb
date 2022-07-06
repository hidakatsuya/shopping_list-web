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

    assert_field 'token_value', with: @logged_user.token.value
    assert_button 'Regenerate'
    assert_button 'Delete'
  end

  test 'language' do
    select 'ja', from: 'Language'
    click_on 'Save'

    # Check that the UI texts are rendered in the changed locale (ja).
    I18n.with_locale('ja') do
      assert_select Setting.human_attribute_name(:locale), selected: 'ja'
      assert_button I18n.t('settings.setting_form.save')

      assert_text Token.human_attribute_name(:value)
      assert_button I18n.t('settings.edit.sign_out')
    end
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
