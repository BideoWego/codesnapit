class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  before_create :build_profile

  validates :username, length: { in: 3..12 }

end
