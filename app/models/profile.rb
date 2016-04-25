require 'uri'

class Profile < ActiveRecord::Base

  belongs_to :user

  validates :full_name, length: { in: 5..20 }, allow_blank: true
  validates :website, length: { in: 3..40 }, allow_blank: true, url: true
  validates :bio, length: { in: 10..400 }, allow_blank: true

  private

  def valid_url?
    !!URI.parse(website)
  rescue URI::InvalidURIError
    errors.add(:website, "isn't a valid web address")
  end

end
