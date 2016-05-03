require './lib/tasks/helpers/task_logger'
require './lib/tasks/helpers/ace'

# ----------------------------------------
# Editor Task Helper
# ----------------------------------------


module Editor
  extend TaskLogger

  def self.seed_languages
    Ace.each_mode do |mode|
      name = mode['name']
      editor_name = mode['file']
      snap_it_language = SnapItLanguage.find_by_editor_name(editor_name)
      unless snap_it_language
        puts "Seeding language: #{editor_name}"
        SnapItLanguage.create({
          :name => name,
          :editor_name => editor_name
        })
      end
    end
  end


  def self.seed_themes
    Ace.each_theme do |theme|
      name = theme['name']
      editor_name = theme['file']
      snap_it_theme = SnapItTheme.find_by_editor_name(editor_name)
      unless snap_it_theme
        puts "Seeding theme: #{editor_name}"
        SnapItTheme.create({
          :name => name,
          :editor_name => editor_name
        })
      end
    end
  end
end



