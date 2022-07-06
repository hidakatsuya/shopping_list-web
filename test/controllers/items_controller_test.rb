# frozen_string_literal: true

require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @logged_user = users(:user_a)
    @item = items(:one)

    sign_in @logged_user
  end

  test 'index' do
    get items_path

    assert_response :success
    assert_equal @logged_user.items.incompleted, controller_assigns(:items)
  end

  test 'new' do
    get new_item_path

    assert_response :success
    assert_equal @logged_user, controller_assigns(:item).user
  end

  test 'create with valid params' do
    assert_difference ->{ @logged_user.items.count }, 1 do
      post items_path, params: { item: { name: 'New Item' } }
    end

    assert_equal @logged_user, Item.find_by(name: 'New Item').user
    assert_redirected_to items_path
  end

  test 'create with invalid params' do
    assert_no_difference ->{ Item.count } do
      post items_path, params: { item: { name: '' } }
    end

    assert_response :unprocessable_entity
  end

  test 'edit' do
    get edit_item_path(@item)

    assert_response :success
  end

  test 'update with valid params' do
    patch item_path(@item), params: { item: { name: 'Changed Item' } }

    assert_equal 'Changed Item', @item.reload.name
    assert_redirected_to items_path
  end

  test 'update with invalid params' do
    patch item_path(@item), params: { item: { name: '' } }

    assert_response :unprocessable_entity
  end

  test 'update other users item' do
    assert_raises ActiveRecord::RecordNotFound do
      patch item_path(items(:three)), params: { item: { name: 'Changed Item' } }
    end
  end

  test 'destroy' do
    assert_difference('Item.count', -1) do
      delete item_path(@item)
    end
    assert_redirected_to items_path
  end

  test 'destroy other users item' do
    assert_raises ActiveRecord::RecordNotFound do
      patch item_path(items(:three)), params: { item: { name: 'Changed Item' } }
    end
  end

  test 'complete' do
    item = items(:one)
    post complete_item_path(item)

    assert_equal true, item.reload.completed?
    assert_redirected_to items_path
  end

  test 'incomplete' do
    item = items(:two)
    post incomplete_item_path(item)

    assert_equal false, item.reload.completed?
    assert_redirected_to items_path
  end
end
