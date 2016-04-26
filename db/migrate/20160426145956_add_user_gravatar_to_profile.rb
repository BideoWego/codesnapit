class AddUserGravatarToProfile < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.boolean :gravatar, default: false
    end
  end
end
