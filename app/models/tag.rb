class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :snap_its, :through => :taggings, :source => :taggable, :source_type => 'SnapIt'

  validates :name,
            :presence => true,
            :uniqueness => true
end
