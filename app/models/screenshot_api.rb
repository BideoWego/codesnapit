class ScreenshotAPI < ActiveRecord::Base
  END_POINT = ENV['SCREENSHOT_URL']


  def self.get_base64(url)
    get(url, { :format => 'base64' })
  end


  def self.get_image_src(url)
    get(url, { :format => 'image_src' })
  end


  def self.get_image(url)
    get(url)
  end


  def self.get(url, options={})
    response = HTTParty.post(END_POINT, :body => { :url => url }.merge(options))
  end
end
