class RemoveNotNullEditorName < ActiveRecord::Migration
  def change
    change_column_null(:snap_it_languages, :editor_name, true)
    change_column_null(:snap_it_themes, :editor_name, true)
  end
end
