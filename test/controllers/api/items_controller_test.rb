# frozen_string_literal: true

require 'test_helper'

class Api::ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_a)
  end

  test 'create with invalid token' do
    post api_items_path, params: { name: 'New item' },
                         headers: headers(token: 'unknown')

    assert_response :unauthorized
  end

  test 'create with invalid params' do
    post api_items_path, params: {}, headers: headers
    assert_response :bad_request
  end

  test 'create with empty name param' do
    assert_no_difference ->{ Item.count } do
      post api_items_path, params: { name: '' }, headers: headers
    end

    assert_response :unprocessable_entity
    assert_equal({ 'message' => "Name can't be blank" }, JSON.parse(response.body))
  end

  test 'create' do
    assert_difference ->{ @user.items.count }, 1 do
      post api_items_path, params: { name: 'New item' }, headers: headers
    end

    assert_response :created
  end


  private

  def headers(token: nil)
    { 'Authorization' => "Bearer #{token || @user.token.value}" }
  end
end
