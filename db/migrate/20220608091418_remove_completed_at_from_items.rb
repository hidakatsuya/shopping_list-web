class RemoveCompletedAtFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :completed_at, :datetime
  end
end
