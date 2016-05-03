class CreateSnapIts < ActiveRecord::Migration
  def change
    create_table :snap_its do |t|

      t.timestamps null: false
    end
  end
end
