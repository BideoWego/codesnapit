class CreateSnapItLanguages < ActiveRecord::Migration
  def change
    create_table :snap_it_languages do |t|
      t.string :name, :null => false
      t.string :editor_name, :null => false

      t.index :name, :unique => true
      t.index :editor_name, :unique => true

      t.timestamps null: false
    end
  end
end
