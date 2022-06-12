require 'application_system_test_case'

class TokensTest < ApplicationSystemTestCase
  test 'show with user has token' do
    logged_user = login_user

    visit token_path

    assert_text 'APIトークン'
    assert_field 'token-value', with: logged_user.token.value
    assert_selector 'button', text: '再生成'
    assert_button '削除'
  end

  test 'show with user has no token' do
    logged_user = login_user(:user_b)

    visit token_path

    assert_text 'APIトークン'
    assert_field 'token-value', with: ''
    assert_selector 'button', text: '生成'
    assert_no_button '削除'
  end

  test 'generate with user has no token' do
    logged_user = login_user(:user_b)

    visit token_path

    click_on '生成'

    assert_text 'APIトークン'
    assert_field 'token-value', with: logged_user.reload.token.value
    assert_selector 'button', text: '再生成'
    assert_button '削除'
  end

  test 'regenerate with user has token' do
    logged_user = login_user

    visit token_path

    click_on '生成'

    assert_text 'APIトークン'
    assert_field 'token-value', with: logged_user.reload.token.value
    assert_selector 'button', text: '再生成'
    assert_button '削除'
  end

  test 'delete with user has token' do
    logged_user = login_user

    visit token_path

    click_on '削除'

    assert_text 'APIトークン'
    assert_field 'token-value', with: ''
    assert_selector 'button', text: '生成'
    assert_no_button '削除'
  end

  private

  def login_user(fixture_key = :user_a)
    users(fixture_key).tap { |u| login_as u }
  end
end
