# frozen_string_literal: true

class Setting < ApplicationRecord
  belongs_to :user

  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s), allow_blank: true },
                     presence: true
end
