# frozen_string_literal: true

require "application_system_test_case"

class TokensTest < ApplicationSystemTestCase
  test "show with user has token" do
    logged_user = login_user

    visit token_path

    assert_text "API Token"
    assert_field "token_value", with: logged_user.token.value
    assert_button "Regenerate"
    assert_button "Delete"
  end

  test "show with user has no token" do
    logged_user = login_user(:user_b)

    visit token_path

    assert_text "API Token"
    assert_field "token_value", with: ""
    assert_button "Generate"
    assert_no_button "Delete"
  end

  test "generate with user has no token" do
    logged_user = login_user(:user_b)

    visit token_path

    ::Token.stub :generate_token, "generated token" do
      click_on "Generate"

      assert_text "API Token"
      assert_field "token_value", with: "generated token"
      assert_button "Regenerate"
      assert_button "Delete"
    end
  end

  test "regenerate with user has token" do
    logged_user = login_user

    visit token_path

    ::Token.stub :generate_token, "regenerated token" do
      click_on "Regenerate"

      assert_text "API Token"
      assert_field "token_value", with: "regenerated token"
      assert_button "Regenerate"
      assert_button "Delete"
    end
  end

  test "delete with user has token" do
    logged_user = login_user

    visit token_path

    click_on "Delete"

    assert_text "API Token"
    assert_field "token_value", with: ""
    assert_button "Generate"
    assert_no_button "Delete"
  end

  private

  def login_user(fixture_key = :user_a)
    users(fixture_key).tap { |u| login_as u }
  end
end
