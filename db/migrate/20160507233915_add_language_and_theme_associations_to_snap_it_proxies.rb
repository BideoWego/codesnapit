class AddLanguageAndThemeAssociationsToSnapItProxies < ActiveRecord::Migration
  def change
    change_table(:snap_it_proxies) do |t|
      if t.column_exists?(:language)
        t.remove :language
      end
      if t.column_exists?(:theme)
        t.remove :theme
      end

      t.integer :snap_it_language_id
      t.integer :snap_it_theme_id

      t.index :snap_it_language_id
      t.index :snap_it_theme_id
    end
  end
end
