# ----------------------------------------
# Ace Tasks
# ----------------------------------------

namespace :ace do
  desc 'Copy all Ace support files to public/ folder'

  task :import => :environment do
    puts 'Copying Ace files to public/ directory'

    src = './vendor/assets/bower_components/ace-builds/src-noconflict/'
    dest = './public/'
    [
      'ext',
      'keybinding',
      'mode',
      'worker'
    ].each do |prefix|
      pattern = "#{src}#{prefix}-*.js"
      Dir.glob(pattern) do |file|
        filename = file.split('/').last
        FileUtils.cp(file, "#{dest}/#{filename}")
      end
    end

    puts 'Done'
  end
end





