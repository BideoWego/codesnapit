class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :initiator_id, null: false
      t.integer :following_id, null: false

      t.timestamps null: false
    end

    add_index :follows, [:initiator_id, :following_id], unique: true
  end
end
