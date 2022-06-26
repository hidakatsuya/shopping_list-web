# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'user is signed in' do
    sign_in users(:user_a)
    get root_path
    assert_redirected_to items_path
  end

  test 'user is not signed in' do
    get root_path
    assert_redirected_to new_user_session_path
  end
end
