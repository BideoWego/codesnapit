# ----------------------------------------
# Bower
# ----------------------------------------

namespace :bower do
  desc 'Import bower files into vendor/assets'
  task :js => :environment do
    puts
    puts 'Importing Bower JavaScript files'
    [
      'bootstrap/dist/js/bootstrap',
      'ace-builds/src-min-noconflict/ace',
      'lodash/dist/lodash',
      'angular/angular',
      'restangular/dist/restangular',
      'angular-ui-router/release/angular-ui-router',
      'angular-ui-ace/ui-ace',
      'angular-flash-alert/dist/angular-flash',
      'Caret.js/dist/jquery.caret',
      'At.js/dist/js/jquery.atwho'
    ].each do |bower_path|
      file_name = bower_path.split('/').last
      assets_dir = 'vendor/assets/'
      src = "#{assets_dir}bower_components/#{bower_path}.js"
      dest = "#{assets_dir}javascripts/#{file_name}.js"
      FileUtils.cp(src, dest)
      puts "Imported: #{src}"
      puts "Copied to: #{dest}"
    end

    puts
    puts 'Done'
  end

  task :css => :environment do
    puts
    puts 'Importing Bower CSS files'
    [
      'angular-flash-alert/dist/angular-flash',
      'At.js/dist/css/jquery.atwho'
    ].each do |bower_path|
      file_name = bower_path.split('/').last
      assets_dir = 'vendor/assets/'
      src = "#{assets_dir}bower_components/#{bower_path}.css"
      dest = "#{assets_dir}stylesheets/#{file_name}.css"
      FileUtils.cp(src, dest)
      puts "Imported: #{src}"
      puts "Copied to: #{dest}"
    end

    puts
    puts 'Done'
  end

  task :import => :environment do
    Rake::Task['bower:js'].execute
    Rake::Task['bower:css'].execute
  end
end





