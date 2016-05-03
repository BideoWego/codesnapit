require './lib/tasks/helpers/task_logger'

# ----------------------------------------
# Ace Task Helper
# ----------------------------------------

module Ace
  extend TaskLogger

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
    log_errors(errors)
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
    log_errors(errors)
  end


  def self.each_file(path)
    Ace.prefixes.each do |prefix|
      pattern = "#{path}#{prefix}-*.js"
      Dir.glob(pattern) do |file|
        yield(file)
      end
    end
  end
end


