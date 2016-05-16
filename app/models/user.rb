class User < ActiveRecord::Base
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




  private
  def username_to_slug
    self.slug = username.slugify
  end


  def unique_username_slug
    if User.find_by_slug(self.username.slugify)
      errors.add(:username, "has already been taken")
    end
  end
end
