class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.string :value, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tokens, :value
  end
end
