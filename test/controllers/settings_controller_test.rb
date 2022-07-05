require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'update with user whose has no setting' do
    user = sign_in_with(:user_b)

    assert_difference ->{ Setting.where(user: user).count }, 1 do
      put setting_path, params: { setting: { locale: 'ja' } }
    end

    assert_equal 'ja', user.reload.setting.locale
    assert_redirected_to settings_path
  end

  test 'update with user whose has setting' do
    user = sign_in_with(:user_a)

    assert_no_difference ->{ Setting.count } do
      put setting_path, params: { setting: { locale: 'ja' } }
    end

    assert_equal 'ja', user.reload.setting.locale
    assert_redirected_to settings_path
  end

  test 'update with invalid locale' do
    user = sign_in_with(:user_a)

    put setting_path, params: { setting: { locale: 'unknown locale' } }

    assert_response :unprocessable_entity
    assert controller_assigns(:setting).errors.of_kind?(:locale, :inclusion)
  end

  private

  def sign_in_with(user_key)
    users(user_key).tap { |user| sign_in user }
  end
end
