# frozen_string_literal: true

require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "remaining_item_notification" do
    user = users(:user_a)

    email = UserMailer.remaining_item_notification(user, user.items.count)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [ "no-reply@example.com" ], email.from
    assert_equal [ user.email ], email.to
    assert_equal "You have #{user.items.count} remaining item(s)", email.subject

    assert_equal read_fixture("remaining_item_notification.txt").join, email.text_part.body.to_s
    assert_includes email.html_part.body.to_s, read_fixture("remaining_item_notification.html").join
  end
end
