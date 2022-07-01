require 'application_system_test_case'

class SignInTest < ApplicationSystemTestCase
  setup do
    omniauth_mock

    visit root_path
  end

  test 'sign-in with registered user' do
    omniauth_mock_add(uid: users(:user_a).uid)

    click_on 'Google でログイン'

    assert_link '追加する'
    assert_text 'Item One'
  end

  test 'sign-in with new user when create_user_if_not_exists is enabled' do
    Rails.configuration.stub :create_user_if_not_exists, true do
      click_on 'Google でログイン'

      assert_link '追加する'
      assert_text 'アイテムはありません'
    end
  end

  test 'sign-in with new user when create_user_if_not_exists is disabled' do
    Rails.configuration.stub :create_user_if_not_exists, false do
      click_on 'Google でログイン'

      assert_text 'ログインできません。'
      assert_button 'Google でログイン'
    end
  end
end
