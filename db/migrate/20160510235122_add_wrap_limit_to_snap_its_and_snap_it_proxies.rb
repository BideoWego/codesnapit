class AddWrapLimitToSnapItsAndSnapItProxies < ActiveRecord::Migration
  def change
    change_table(:snap_its) do |t|
      t.integer :wrap_limit

      t.index :wrap_limit
    end


    change_table(:snap_it_proxies) do |t|
      t.integer :wrap_limit

      t.index :wrap_limit
    end
  end
end
