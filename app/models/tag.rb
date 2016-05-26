class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :snap_its, :through => :taggings, :source => :taggable, :source_type => 'SnapIt'
  has_many :comments, :through => :taggings, :source => :taggable, :source_type => 'Comment'

  validates :name,
            :presence => true,
            :uniqueness => true
end
