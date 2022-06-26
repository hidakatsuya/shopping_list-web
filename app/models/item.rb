# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }
  scope :incompletes, -> { where(completed: false) }
  scope :completes, -> { where(completed: true) }

  def complete
    update(completed: true)
  end

  def incomplete
    update(completed: false)
  end
end
