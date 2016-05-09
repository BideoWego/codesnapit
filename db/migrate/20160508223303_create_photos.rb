class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :attachable_type
      t.integer :attachable_id

      t.attachment :file

      t.index :attachable_type
      t.index :attachable_id

      t.timestamps null: false
    end

    change_table(:snap_its) do |t|
      t.integer :photo_id

      t.index :photo_id, :unique => true
    end
  end
end
