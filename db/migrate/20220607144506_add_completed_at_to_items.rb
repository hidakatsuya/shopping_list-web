class AddCompletedAtToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :completed_at, :datetime
  end
end
