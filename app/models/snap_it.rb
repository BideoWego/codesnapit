class SnapIt < ActiveRecord::Base
  belongs_to :user
  belongs_to :snap_it_language
  belongs_to :snap_it_theme
  has_one :photo, :as => :attachable, :dependent => :destroy


  validates :title,
            :presence => true

  validates :description,
            :length => { :maximum => 512 },
            :presence => true

  validates :body,
            :presence => true

  validates :user,
            :presence => true

  validates :snap_it_language,
            :presence => true

  validates :snap_it_theme,
            :presence => true


  accepts_nested_attributes_for :photo


  def self.new_from_token(token)
    snap_it_proxy = SnapItProxy.find_by_token(token)
    new({
      :title => snap_it_proxy.title,
      :description => snap_it_proxy.description,
      :body => snap_it_proxy.body,
      :font_size => snap_it_proxy.font_size,
      :photo_attributes => { 
        :file => snap_it_proxy.image_data_to_image_file
      },
      :user_id => snap_it_proxy.user.id,
      :snap_it_language_id => snap_it_proxy.snap_it_language_id,
      :snap_it_theme_id => snap_it_proxy.snap_it_theme_id
    })
  end
end
