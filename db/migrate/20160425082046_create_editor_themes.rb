class CreateEditorThemes < ActiveRecord::Migration
  def change
    create_table :editor_themes do |t|

      t.timestamps null: false
    end
  end
end
