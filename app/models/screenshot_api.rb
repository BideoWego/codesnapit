class ScreenshotAPI < ActiveRecord::Base
  END_POINT = ENV['SCREENSHOT_URL']
  MIN_WIDTH = 256
  DEFAULT_WRAP_LIMIT = 80
  WRAP_FACTOR = 0.8125
  HEIGHT_FACTOR = 1.5


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
    num_lines = snap_it.body.lines.length
    wrap_limit = snap_it.wrap_limit ? snap_it.wrap_limit : DEFAULT_WRAP_LIMIT
    wrap_limit *= WRAP_FACTOR

    lines = snap_it.body.lines
    longest_line = lines.first
    lines.each do |line|
      longest_line = longest_line.length > line.length ? longest_line : line
    end
    num_lines += (longest_line.length / wrap_limit).to_i

    width = font_size * wrap_limit
    width = width > MIN_WIDTH ? width : MIN_WIDTH

    height = font_size * (num_lines * HEIGHT_FACTOR)

    {
      :width => width,
      :height => height
    }
  end
end
