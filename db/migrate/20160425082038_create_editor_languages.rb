class CreateEditorLanguages < ActiveRecord::Migration
  def change
    create_table :editor_languages do |t|

      t.timestamps null: false
    end
  end
end
