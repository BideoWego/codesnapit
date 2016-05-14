class AddColumnToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :slug
    end    
    add_index :users, :slug, unique: true
  end
end
