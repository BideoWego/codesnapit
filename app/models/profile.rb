require 'uri'

class Profile < ActiveRecord::Base

  belongs_to :user

  # Paperclip
  has_attached_file :avatar, 
      styles: { medium: "180x180#", thumb: "32x32#" },
      default_url: ->(attachment) { 
        ActionController::Base.helpers.asset_path('missing_avatar.png') }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, less_than: 5.megabytes

  validates :full_name, length: { in: 5..20 }, allow_blank: true
  validates :website, length: { in: 3..40 }, allow_blank: true, url: true
  validates :bio, length: { in: 10..400 }, allow_blank: true

  before_save :add_http_website


  private


  def add_http_website
    unless website.blank? || /^http?:\/\/|^https?:\/\// =~ website
      self.website = "http://#{website}"
    end
  end

end
