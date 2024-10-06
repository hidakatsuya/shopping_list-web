# frozen_string_literal: true

require "test_helper"
require "google_id_token_payload"

class GoogleIdTokenPayloadTest < ActiveSupport::TestCase
  test "#uid" do
    payload = GoogleIdTokenPayload.new(
      "iss" => "https://accounts.google.com",
      "sub" => "id_token_sub"
    )
    assert_equal "id_token_sub", payload.uid
  end

  test ".load_from with invalid token" do
    assert_nil GoogleIdTokenPayload.load_from("invalid_id_token", google_client_id: "client_id")
  end

  test ".load_from with valid token" do
    mock_validator = Minitest::Mock.new
    mock_validator.expect(
      :check,
      # return value
      { "sub" => "id_token_sub" },
      # expected args
      [ "valid_id_token", "client_id" ]
    )

    GoogleIDToken::Validator.stub(:new, mock_validator) do
      payload = GoogleIdTokenPayload.load_from("valid_id_token", google_client_id: "client_id")
      assert_equal "id_token_sub", payload.uid
      assert_mock mock_validator
    end
  end
end
