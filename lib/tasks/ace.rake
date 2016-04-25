# ----------------------------------------
# Ace Tasks
# ----------------------------------------


# Ace Module
module Ace
  SRC_PATH = 'vendor/assets/bower_components/ace-builds/src-noconflict/'
  PUBLIC_PATH = 'public/js/ace/'
  DATA_MODES = 'data/ace/modes.yml'
  DATA_THEMES = 'data/ace/themes.yml'

  def self.each_src_file
    Ace.each_file(SRC_PATH) do |file|
      yield(file)
    end
  end


  def self.each_public_file
    Ace.each_file(PUBLIC_PATH) do |file|
      yield(file)
    end
  end


  def self.cp_src_to_public
    FileUtils.mkdir_p(PUBLIC_PATH)
    Ace.each_src_file do |file|
      filename = file.split('/').last
      public_file = "#{PUBLIC_PATH}#{filename}"
      FileUtils.cp(file, public_file)
      yield(public_file)
    end
  end


  def self.clean_public
    Ace.each_public_file do |file|
      FileUtils.safe_unlink(file)
      yield(file)
    end
  end


  def self.seed_modes
    Ace.each_mode do |mode|
      name = mode['name']
      puts "Seeding mode: #{name}"
    end
  end


  def self.seed_themes
    Ace.each_theme do |theme|
      name = theme['name']
      puts "Seeding theme: #{name}"
    end
  end




  private
  def self.prefixes
    [
      'ext',
      'keybinding',
      'mode',
      'worker',
      'theme'
    ]
  end


  def self.each_theme
    data = File.read(DATA_THEMES)
    themes = YAML.load(data)['themes']
    lights = themes['light'].map { |theme| theme['style'] = 'light'; theme }
    darks = themes['dark'].map { |theme| theme['style'] = 'dark'; theme }
    themes = [lights, darks].flatten
    errors = []
    themes.each do |theme|
      name = theme['name']
      file = theme['file']
      style = theme['style']
      path = "#{PUBLIC_PATH}theme-#{file}.js"
      if File.exist?(path)
        puts "Found theme file: #{path}"
        yield(theme)
      else
        errors << "Unable to seed theme #{name}, missing theme file: #{path}"
      end
    end
    puts_errors(errors)
  end


  def self.each_mode
    data = File.read(DATA_MODES)
    modes = YAML.load(data)['modes']
    errors = []
    modes.each do |mode|
      name = mode['name']
      file = mode['file']
      path = "#{PUBLIC_PATH}mode-#{file}.js"
      if File.exist?(path)
        puts "Found mode file: #{path}"
        yield(mode)
      else
        errors << "Unable to seed mode #{name}, missing mode file: #{path}"
      end
    end
    puts_errors(errors)
  end


  def self.each_file(path)
    Ace.prefixes.each do |prefix|
      pattern = "#{path}#{prefix}-*.js"
      Dir.glob(pattern) do |file|
        yield(file)
      end
    end
  end


  def self.puts_errors(errors)
    unless errors.empty?
      puts "\n"
      puts ('*' * 20).colorize(:red)
      puts "\n"
      errors.each do |error|
        puts error.colorize(:red)
      end
    end
  end
end


# Ace Tasks
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


  namespace :seed do
    desc "Seed the data in #{Ace::DATA_MODES}"
    task :modes => :environment do
      puts "Seeding data in #{Ace::DATA_MODES}"
      Ace.seed_modes
      puts 'Done'
    end


    desc "Seed the data in #{Ace::DATA_THEMES}"
    task :themes => :environment do
      puts "Seeding data in #{Ace::DATA_THEMES}"
      Ace.seed_themes
      puts 'Done'
    end
  end
end




  











