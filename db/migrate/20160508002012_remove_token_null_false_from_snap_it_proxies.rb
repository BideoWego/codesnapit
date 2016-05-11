class RemoveTokenNullFalseFromSnapItProxies < ActiveRecord::Migration
  def change
    change_column_null(:snap_it_proxies, :token, true)
  end
end
