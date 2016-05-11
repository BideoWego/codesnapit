class AddColumnsToSnapIts < ActiveRecord::Migration
  def change
    change_table(:snap_its) do |t|
      t.string :title
      t.text :description, :limit => 512
      t.text :body
      t.integer :font_size, :default => 18
      t.integer :user_id
      t.integer :snap_it_language_id
      t.integer :snap_it_theme_id

      t.index :title
      t.index :font_size
      t.index :user_id
      t.index :snap_it_language_id
      t.index :snap_it_theme_id
    end

    change_column_null(:snap_its, :title, false)
    change_column_null(:snap_its, :description, false)
    change_column_null(:snap_its, :body, false)
    change_column_null(:snap_its, :user_id, false)
    change_column_null(:snap_its, :snap_it_language_id, false)
    change_column_null(:snap_its, :snap_it_theme_id, false)
  end
end
