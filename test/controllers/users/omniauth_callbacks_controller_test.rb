# frozen_string_literal: true

require "test_helper"

class Users::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup { omniauth_mock }

  test "callback with auth of new user when registrable_account_emails is blank" do
    registrable_account_emails_stub "" do
      assert_no_difference -> { User.count } do
        get user_google_oauth2_omniauth_callback_path, env: omniauth_mock_request_env
      end

      assert_redirected_to new_user_session_url
    end
  end

  test "callback with auth of new user whose email is included in the registrable_account_emails" do
    registrable_account_emails_stub "user@example.com" do
      assert_difference -> { User.count }, 1 do
        get user_google_oauth2_omniauth_callback_path, env: omniauth_mock_request_env
      end

      assert_equal "user@example.com", controller_assigns(:user).email
      assert_redirected_to root_path
    end
  end

  test "callback with auth of new user whose email is not included in the registrable_account_emails" do
    registrable_account_emails_stub "a@example.com", "b@example.com"  do
      assert_no_difference -> { User.count } do
        get user_google_oauth2_omniauth_callback_path, env: omniauth_mock_request_env
      end

      assert_redirected_to new_user_session_url
    end
  end

  test "callback with auth of registered user" do
    omniauth_mock_add(uid: users(:user_a).uid)

    assert_no_difference -> { User.count } do
      get user_google_oauth2_omniauth_callback_path, env: omniauth_mock_request_env
    end

    assert_equal users(:user_a), controller_assigns(:user)
    assert_redirected_to root_path
  end
end
