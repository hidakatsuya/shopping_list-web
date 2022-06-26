# frozen_string_literal: true

class AddCompletedIndexToItems < ActiveRecord::Migration[7.0]
  def change
    add_index :items, :completed
  end
end
