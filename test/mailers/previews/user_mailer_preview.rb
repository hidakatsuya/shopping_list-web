# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def remaining_item_notification
    user = User.first
    UserMailer.remaining_item_notification(user, user.items.count)
  end
end
