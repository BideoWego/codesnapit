class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :verb
      t.integer :user_id
      t.integer :activity_feedable_id
      t.string :activity_feedable_type

      t.index :verb
      t.index :user_id
      t.index :activity_feedable_id
      t.index :activity_feedable_type

      t.timestamps null: false
    end
  end
end
