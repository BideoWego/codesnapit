class FixPolymorphicColumnNames < ActiveRecord::Migration
  def change
    rename_column :comments, :commentable_type, :parent_type
    rename_column :comments, :commentable_id, :parent_id
    rename_column :likes, :likeable_type, :parent_type
    rename_column :likes, :likeable_id, :parent_id
  end
end
