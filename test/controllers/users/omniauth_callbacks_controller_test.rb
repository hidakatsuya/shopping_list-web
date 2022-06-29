# frozen_string_literal: true

require 'test_helper'

class Users::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup { omniauth_mock }

  test 'callback with unknown user auth when CREATE_USER_IF_NOT_EXISTS is not set' do
    Rails.configuration.stub :create_user_if_not_exists, false do
      get user_google_oauth2_omniauth_callback_path, env: omniauth_mock_request_env

      assert_redirected_to new_user_session_url
    end
  end

  test 'callback with unknown user auth when CREATE_USER_IF_NOT_EXISTS is set' do
    Rails.configuration.stub :create_user_if_not_exists, true do
      assert_difference ->{ User.count }, 1 do
        get user_google_oauth2_omniauth_callback_path, env: omniauth_mock_request_env
      end
      assert_redirected_to root_path
    end
  end

  test 'callback with registered user' do
    omniauth_mock_add(uid: users(:user_a).uid)

    assert_no_difference ->{ User.count } do
      get user_google_oauth2_omniauth_callback_path, env: omniauth_mock_request_env
    end

    assert_equal users(:user_a), controller_assigns(:user)
    assert_redirected_to root_path
  end
end
