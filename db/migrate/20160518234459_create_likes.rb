class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :creator_id
      t.references :likeable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
