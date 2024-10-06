# frozen_string_literal: true

require "test_helper"

class TokensControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "show" do
    logged_user = login_user

    get token_path

    assert_response :success
    assert_equal logged_user.token, controller_assigns(:token)
  end

  test "regenerate with user has no token" do
    logged_user = login_user(:user_b)

    assert_difference -> { Token.count }, 1 do
      patch regenerate_token_path
    end
    assert_response :redirect
  end

  test "regenerate with user has token" do
    logged_user = login_user

    assert_changes -> { logged_user.token.value } do
      patch regenerate_token_path
    end
    assert_response :redirect

    assert_no_difference -> { Token.count } do
      patch regenerate_token_path
    end
  end

  test "destroy with user has no token" do
    logged_user = login_user(:user_b)

    assert_no_difference -> { Token.count } do
      delete token_path
    end
    assert_response :unprocessable_entity
  end

  test "destroy with user has token" do
    logged_user = login_user

    assert_difference -> { Token.count }, -1 do
      delete token_path
    end
    assert_nil logged_user.reload.token
    assert_response :redirect
  end

  private

  def login_user(fixture_key = :user_a)
    users(fixture_key).tap { |u| login_as u }
  end
end
