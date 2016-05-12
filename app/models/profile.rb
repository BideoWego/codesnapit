class Profile < ActiveRecord::Base

  belongs_to :user

  # Paperclip
  has_attached_file :avatar,
      styles: { medium: "180x180#", small: "32x32#" },
      default_url: 'missing_avatar_:style.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, less_than: 5.megabytes

  validates :full_name, length: { in: 5..20 }, allow_blank: true
  validates :website, length: { in: 3..40 }, allow_blank: true, url: true
  validates :bio, length: { in: 10..400 }, allow_blank: true

  after_post_process :disable_gravatar

  before_save :add_http_website


  def gr_or_avatar(size = :medium)
    if !!self.gravatar
      gravatar_size = size == :medium ? 180 : 32
      hash = Digest::MD5.hexdigest self.user.email.downcase
      "http://www.gravatar.com/avatar/#{hash}?s=#{gravatar_size}"
    else
      self.avatar.url(size)
    end
  end


  private


  def add_http_website
    unless website.blank? || /^http?:\/\/|^https?:\/\// =~ website
      self.website = "http://#{website}"
    end
  end


  def disable_gravatar
    self.gravatar = false
  end

end
