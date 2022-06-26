# frozen_string_literal: true

class AddUserReferenceToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :user, null: false, foreign_key: true
  end
end
