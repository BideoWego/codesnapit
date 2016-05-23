class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.string :taggable_type

      t.index :tag_id
      t.index :taggable_id
      t.index :taggable_type
      t.index [:tag_id, :taggable_id, :taggable_type], :unique => true

      t.timestamps null: false
    end
  end
end
