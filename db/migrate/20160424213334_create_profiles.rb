class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :full_name
      t.string :website
      t.text :bio

      t.timestamps null: false
    end
  end
end
