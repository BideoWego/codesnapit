require './lib/tasks/helpers/ace'

# ----------------------------------------
# Ace Tasks
# ----------------------------------------


namespace :ace do
  desc "Copy all Ace support files to #{Ace::PUBLIC_PATH}"
  task :import => :environment do
    puts "Copying Ace files to #{Ace::PUBLIC_PATH} directory"
    Ace.cp_src_to_public { |file| puts "Copied: #{file}" }
    puts 'Done'
  end


  desc "Remove all Ace support files from #{Ace::PUBLIC_PATH}"
  task :clean => :environment do
    puts "Removing Ace files in #{Ace::PUBLIC_PATH} directory"
    Ace.clean_public { |file| puts "Removed: #{file}" }
    puts 'Done'
  end
end




  











