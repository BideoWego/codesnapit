class UniqueLikes < ActiveRecord::Migration
  def change
    add_index :likes, [:user_id, :parent_id, :parent_type], unique: true
  end
end
