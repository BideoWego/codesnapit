class ChangeLikesAndCommentsUserColumn < ActiveRecord::Migration
  def change
    rename_column :likes, :creator_id, :user_id
    rename_column :comments, :author_id, :user_id
  end
end
