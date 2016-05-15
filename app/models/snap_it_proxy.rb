class SnapItProxy < ActiveRecord::Base
  END_POINT = ENV['TARGET_URL']

  belongs_to :user
  belongs_to :snap_it_language
  belongs_to :snap_it_theme

  before_create :create_token
  after_create :clean_up


  validates :title,
            :presence => true

  validates :description,
            :length => { :maximum => 512 },
            :presence => true

  validates :body,
            :presence => true

  validates :user,
            :presence => true

  # TODO should validate that editor_name is NOT NULL
  validates :snap_it_language,
            :presence => true

  validates :snap_it_theme,
            :presence => true

  validate :unique_token?

  # TODO should validate numeric values for font_size and wrap_limit but only if present



  def create_image_data
    options = ScreenshotAPI.options_for(self)
    response = ScreenshotAPI.get_base64(build_url, options)
    update!(:image_data => response)
  end


  def image_data_to_image_file
    data = "data:image/jpeg;base64,#{image_data}"
    image = Paperclip.io_adapters.for(data)
    image.original_filename = "#{token}.jpg"
    image
  end


  private
  def clean_up
    user.snap_it_proxies
      .where.not(:id => id)
      .destroy_all
  end


  def create_token
    str = "#{user_id}@#{Time.now} #{Time.now.usec}"
    hash = Digest::MD5.new.hexdigest(str)
    self.token = hash
  end


  def build_url
    segments = [END_POINT, '?']
    parameters = []
    {
      :token => token
    }.each do |key, value|
      parameters << "#{key}=#{value}"
    end
    "#{segments.join}#{parameters.join('&')}"
  end


  def unique_token?
    if SnapItProxy.find_by_token(token)
       errors.add(:base, 'Token invalid')
     end
  end
end















