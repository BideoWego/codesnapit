class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :snap_its, :through => :taggings, :source => :taggable, :source_type => 'SnapIt'
  has_many :comments, :through => :taggings, :source => :taggable, :source_type => 'Comment'


  validates :name,
            :presence => true,
            :uniqueness => true


  def self.tags_from_text(text)
    text.scan(/.?#[A-Za-z_0-9]+/)
      .map { |tag| tag.strip }
      .reject { |tag| tag.chars.first != '#' }
      .map { |tag| tag[1..-1] }
  end
end
