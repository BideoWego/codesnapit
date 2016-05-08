class AddImageDataToSnapItProxies < ActiveRecord::Migration
  def change
    change_table(:snap_it_proxies) do |t|
      t.text :image_data
    end
  end
end
