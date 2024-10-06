require "application_system_test_case"

class SignInTest < ApplicationSystemTestCase
  setup do
    omniauth_mock

    visit root_path
  end

  test "sign-in with registered user" do
    omniauth_mock_add(uid: users(:user_a).uid)

    click_on "Sign in with Google"

    assert_link "Add item"
    assert_text "Item One"
  end

  test "sign-in with new user whose email is included in the registrable_account_emails" do
    registrable_account_emails_stub "user@example.com" do
      click_on "Sign in with Google"

      assert_link "Add item"
      assert_text "No items"
    end
  end

  test "sign-in with new user whose email is not included in the registrable_account_emails" do
    registrable_account_emails_stub "other@example.com" do
      click_on "Sign in with Google"

      assert_text "Could not sign in"
      assert_button "Sign in with Google"
    end
  end
end
