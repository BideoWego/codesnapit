# ----------------------------------------
# Bower
# ----------------------------------------

namespace :bower do
  desc 'Import JavaScript files into vendor/assets/javascripts'
  task :js => :environment do
    puts 'Importing Bower JavaScript files'
    [
      'bootstrap/dist/js/bootstrap',
      'ace-builds/src-min-noconflict/ace',
      'lodash/dist/lodash',
      'angular/angular',
      'restangular/dist/restangular',
      'angular-ui-router/release/angular-ui-router',
      'angular-ui-ace/ui-ace'
    ].each do |bower_path|
      file_name = bower_path.split('/').last
      assets_dir = 'vendor/assets/'
      src = "#{assets_dir}bower_components/#{bower_path}.js"
      dest = "#{assets_dir}javascripts/#{file_name}.js"
      FileUtils.cp(src, dest)
      puts "Imported: #{src}"
      puts "Copied to: #{dest}"
    end
    puts 'Done'
  end
end





