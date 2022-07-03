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

  test 'sign-in with new user whose email is included in the registrable_account_emails' do
    registrable_account_emails_stub 'user@example.com' do
      click_on 'Google でログイン'

      assert_link '追加する'
      assert_text 'アイテムはありません'
    end
  end

  test 'sign-in with new user whose email is not included in the registrable_account_emails' do
    registrable_account_emails_stub 'other@example.com' do
      click_on 'Google でログイン'

      assert_text 'ログインできません。'
      assert_button 'Google でログイン'
    end
  end
end
