# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def remaining_item_notification(user, item_count)
    @item_names = user.items.incompleted.ordered.limit(10).pluck(:name)

    mail(
      to: user.email,
      subject: default_i18n_subject(item_count: item_count)
    )
  end
end
