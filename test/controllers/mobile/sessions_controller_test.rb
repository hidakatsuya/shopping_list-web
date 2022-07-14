# frozen_string_literal: true

require 'test_helper'
require 'google_id_token_payload'

class Mobile::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'create with invalid id token' do
    GoogleIdTokenPayload.stub :load_from, payload_double(uid: nil) do
      get mobile_sign_in_path(id_token: 'id_token')
      assert_redirected_to mobile_sign_in_path
    end
  end

  test 'create with unknown uid of id token payload' do
    GoogleIdTokenPayload.stub :load_from, payload_double(uid: 'unknown uid') do
      get mobile_sign_in_path(id_token: 'id_token')
      assert_redirected_to mobile_sign_in_path
    end
  end

  test 'create with valid id token' do
    GoogleIdTokenPayload.stub :load_from, payload_double(uid: users(:user_a).uid) do
      get mobile_sign_in_path(id_token: 'id_token')
      assert_redirected_to items_path
    end
  end

  private

  def payload_double(uid:)
    OpenStruct.new(uid: uid)
  end
end
