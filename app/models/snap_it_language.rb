class SnapItLanguage < ActiveRecord::Base
  has_many :snap_its
  has_many :snap_it_proxies

  validates :name,
            :presence => true,
            :uniqueness => true,
            :on => :create

  validates :name,
            :uniqueness => true,
            :on => :update,
            :allow_blank => true

  validates :editor_name,
            :presence => true,
            :uniqueness => true,
            :on => :create
end
