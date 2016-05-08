class AddFontSizeToSnapItProxies < ActiveRecord::Migration
  def change
    change_table(:snap_it_proxies) do |t|
      t.integer :font_size, :default => 18

      t.index :font_size
    end
  end
end
