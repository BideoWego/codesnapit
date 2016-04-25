class CreateSnapItLanguages < ActiveRecord::Migration
  def change
    create_table :snap_it_languages do |t|

      t.timestamps null: false
    end
  end
end
