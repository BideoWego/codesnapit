# ----------------------------------------
# Ace Tasks
# ----------------------------------------


# Ace Module
module Ace
  SRC_PATH = 'vendor/assets/bower_components/ace-builds/src-noconflict/'
  PUBLIC_PATH = 'public/js/ace/'

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


  def self.each_file(path)
    Ace.prefixes.each do |prefix|
      pattern = "#{path}#{prefix}-*.js"
      Dir.glob(pattern) do |file|
        yield(file)
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
end








