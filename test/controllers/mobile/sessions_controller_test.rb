# frozen_string_literal: true

require 'test_helper'
require 'google_id_token_payload'

class Mobile::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'create with invalid id token' do
    mock_google_id_token_validator uid: nil do
      get mobile_sign_in_path(id_token: 'id_token')
      assert_redirected_to mobile_sign_in_path
    end
  end

  test 'create with unknown uid of id token payload' do
    mock_google_id_token_validator uid: 'unknown uid' do
      get mobile_sign_in_path(id_token: 'id_token')
      assert_redirected_to mobile_sign_in_path
    end
  end

  test 'create with valid id token' do
    mock_google_id_token_validator uid: users(:user_a).uid do
      get mobile_sign_in_path(id_token: 'id_token')
      assert_redirected_to items_path
    end
  end

  private

  def mock_google_id_token_validator(uid:, &block)
    mock_validator = Minitest::Mock.new
    mock_validator.expect(:check, { 'sub' => uid }) { |arg1| arg1 == 'id_token' }

    GoogleIDToken::Validator.stub(:new, mock_validator, &block)

    assert_mock mock_validator
  end
end
