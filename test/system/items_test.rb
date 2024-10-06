# frozen_string_literal: true

require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @logged_user = users(:user_a)
    login_as @logged_user
  end

  test "Showing the index with empty items" do
    @logged_user.items.destroy_all

    visit items_path
    assert_text "No items"
  end

  test "Adding a new item" do
    visit items_path

    click_on "Add item"
    fill_in "Name", with: "Capybara item"

    click_on "Submit"

    assert_text "Capybara item"
  end

  test "Updating an item" do
    visit items_path

    click_on "Edit", match: :first
    fill_in "Name", with: "Updated item"

    click_on "Submit"

    assert_text "Updated item"
  end

  test "Destroying an item" do
    visit items_path

    click_on "Delete", match: :first

    assert_text "No items"
  end

  test "Doing complete/incomplete an item" do
    visit items_path

    assert_no_selector ".line-through", text: items(:one).name

    click_on "Complete", match: :first

    assert_selector ".line-through", text: items(:one).name

    click_on "Incomplete", match: :first

    assert_no_selector ".line-through", text: items(:one).name

    assert_button "Complete"
  end
end
