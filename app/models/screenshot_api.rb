class ScreenshotAPI < ActiveRecord::Base
  END_POINT = ENV['SCREENSHOT_URL']
  MIN_WIDTH = 256
  DEFAULT_WRAP_LIMIT = 80
  WRAP_FACTOR = 0.8125
  HEIGHT_FACTOR = 1.75


  def self.get_base64(url, options={})
    get(url, { :format => 'base64' }.merge(options))
  end


  def self.get_image_src(url, options={})
    get(url, { :format => 'image_src' }.merge(options))
  end


  def self.get_image(url, options={})
    get(url, options)
  end


  def self.get(url, options={})
    response = HTTParty.post(END_POINT, :body => { :url => url }.merge(options))
  end



  private
  def self.options_for(snap_it)
    font_size = snap_it.font_size
    wrap_limit = snap_it.wrap_limit ? snap_it.wrap_limit : DEFAULT_WRAP_LIMIT
    wrap_limit *= WRAP_FACTOR

    lines = snap_it.body.lines
    num_lines = 0

    lines.each do |line|
      result = (line.length.to_f / wrap_limit.to_f).ceil
      result = 1 if result.to_i == 0
      num_lines += result
    end

    width = font_size * wrap_limit
    width = width > MIN_WIDTH ? width : MIN_WIDTH

    num_lines *= HEIGHT_FACTOR
    height = font_size * num_lines

    {
      :width => width,
      :height => height
    }
  end
end
