class SnapItLanguage < ActiveRecord::Base
  has_many :snap_its
  has_many :snap_it_proxies

  validates :name,
            :presence => true,
            :uniqueness => true

  validates :editor_name,
            :presence => true,
            :uniqueness => true
end
