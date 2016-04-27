class CreateSnapItProxies < ActiveRecord::Migration
  def change
    create_table :snap_it_proxies do |t|
      t.string :language, :null => false
      t.string :theme, :null => false
      t.text :body, :null => false
      t.string :token, :null => false
      t.integer :user_id, :null => false

      t.index :user_id
      t.index :token, :unique => true

      t.timestamps null: false
    end
  end
end
