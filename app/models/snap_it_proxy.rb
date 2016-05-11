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

  # TODO should validate that
  # editor_name is NOT NULL
  validates :snap_it_language,
            :presence => true

  validates :snap_it_theme,
            :presence => true


  def create_image_data
    response = ScreenshotAPI.get_base64(build_url)
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
    SnapItProxy.where(:user_id => user_id)
      .where('id != ?', id)
      .destroy_all
  end


  def create_token
    str = "#{user_id}@#{Time.now} #{Time.now.usec}"
    hash = Digest::MD5.new.hexdigest(str)
    self.token = hash
  end


  def build_url
    [
      END_POINT,
      '?',
      'token',
      '=',
      token
    ].join
  end
end
