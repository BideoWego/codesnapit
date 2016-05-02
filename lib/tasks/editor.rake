require './lib/tasks/helpers/editor'

# ----------------------------------------
# Editor
# ----------------------------------------


namespace :editor do
  namespace :seed do
    desc "Seed the editor languages"
    task :languages => :environment do
      puts "Seeding editor languages"
      Editor.seed_languages
      puts 'Done'
    end


    desc "Seed the editor themes"
    task :themes => :environment do
      puts "Seeding editor themes"
      Editor.seed_themes
      puts 'Done'
    end
  end
end



