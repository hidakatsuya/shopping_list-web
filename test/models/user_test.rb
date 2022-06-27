# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '.from_omniauth with registered user' do
    user = users(:user_a)

    assert_equal user, ::User.from_omniauth(provider: 'google_oauth2',
                                            uid: user.uid,
                                            email: user.email)
  end

  test '.from_omniauth with new user' do
    user = nil

    assert_no_changes ->{ User.count } do
      user = ::User.from_omniauth(provider: 'google_oauth2',
                                  uid: 9999,
                                  email: 'new_user@example.com')
    end
    assert_nil user
  end

  test '.from_omniauth with new user and create_user: true option' do
    auth_attrs = {
      provider: 'google_oauth2',
      uid: 9999,
      email: 'new_user@example.com'
    }
    user = ::User.from_omniauth(**auth_attrs, create_user: true)
    assert ::User.where(auth_attrs.slice(:provider, :uid)).exists?
  end
end
