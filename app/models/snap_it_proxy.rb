class SnapItProxy < ActiveRecord::Base
  END_POINT = ENV['TARGET_URL']
  FONT_SIZES = %w(12 13 14 16 18 20 24 28 32 48 64).map(&:to_i)

  belongs_to :user
  belongs_to :snap_it_language
  belongs_to :snap_it_theme

  after_initialize :create_token
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

  validates :token,
            :presence => true,
            :uniqueness => true

  validates :font_size,
            :inclusion => { :in => FONT_SIZES }

  validates :wrap_limit,
            :numericality => {
              :greater_than => 1
            },
            :allow_blank => true

  validate :snap_it_language_editor_name_is_present
  validate :snap_it_theme_editor_name_is_present


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


  def snap_it_language_editor_name_is_present
    snap_it_language = SnapItLanguage.find_by_id(snap_it_language_id)
    unless snap_it_language && snap_it_language.editor_name
      errors.add(:base, "Snap it language is not valid")
    end
  end


  def snap_it_theme_editor_name_is_present
    snap_it_theme = SnapItTheme.find_by_id(snap_it_theme_id)
    unless snap_it_theme && snap_it_theme.editor_name
      errors.add(:base, "Snap it theme is not valid")
    end
  end
end















