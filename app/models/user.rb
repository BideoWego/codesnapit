class User < ActiveRecord::Base
  include Searchable
  searchable_fields :username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :rememberable, :trackable, :validatable, :async

  has_one :profile, dependent: :destroy
  has_many :snap_it_proxies, :dependent => :destroy
  has_many :snap_its, :dependent => :destroy

  has_many :following_relations, foreign_key: :initiator_id, class_name: 'Follow', dependent: :destroy
  has_many :followings, through: :following_relations, source: :following

  has_many :follower_relations, foreign_key: :following_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_relations, source: :initiator

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :activities, :dependent => :destroy

  before_create :build_profile
  before_save :username_to_slug


  validates :username, 
    length: { in: 3..16 }, 
    format: { with: /\A\S+\Z/ },
    uniqueness: true

  validate :unique_username_slug


  def to_param
    slug
  end


  def activity_feed
    Activity.feed_for(self)
  end


  def timeline
    Activity.timeline_for(self)
  end


  private
  def username_to_slug
    self.slug = username.slugify
  end

  def unique_username_slug
    u = User.find_by_slug(self.username.slugify)
    if u && u != self
      errors.add(:username, "has already been taken")
    end
  end

end
