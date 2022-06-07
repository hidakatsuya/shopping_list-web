require 'application_system_test_case'

class ItemsTest < ApplicationSystemTestCase
  setup do
    @logged_user = users(:user_a)
    login_as @logged_user
  end

  test 'Showing the index with empty items' do
    @logged_user.items.destroy_all

    visit items_path
    assert_text 'アイテムはありません'
  end

  test 'Adding a new item' do
    visit items_path

    click_on '新しいアイテム'
    fill_in 'アイテム', with: 'Capybara item'

    click_on '送信'

    assert_text 'Capybara item'
  end

  test 'Updating an item' do
    visit items_path

    click_on '編集', match: :first
    fill_in 'アイテム', with: 'Updated item'

    click_on '送信'

    assert_text 'Updated item'
  end

  test 'Destroying an item' do
    visit items_path

    click_on '削除', match: :first

    assert_text 'アイテムはありません'
  end

  test 'Doing complete/incomplete an item' do
    visit items_path

    assert_no_selector '.text-decoration-line-through', text: items(:one).name

    click_on '完了', match: :first

    assert_selector '.text-decoration-line-through', text: items(:one).name

    click_on '未完了', match: :first

    assert_no_selector '.text-decoration-line-through', text: items(:one).name

    assert_button '完了'
  end
end
