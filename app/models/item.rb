class Item < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }
  scope :incompletes, -> { where(completed: false) }

  broadcasts_to ->(item) { 'item' }, inserts_by: :prepend

  def complete
    update(completed: true)
  end

  def incomplete
    update(completed: false)
  end
end
