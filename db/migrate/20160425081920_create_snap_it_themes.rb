class CreateSnapItThemes < ActiveRecord::Migration
  def change
    create_table :snap_it_themes do |t|

      t.timestamps null: false
    end
  end
end
