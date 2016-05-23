class Comment < ActiveRecord::Base
  default_scope { order('created_at ASC') }

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :parent, polymorphic: true
  has_many :likes, as: :parent, dependent: :destroy

  validates :body, length: {in: 4..512}, presence: true
  validates :author, presence: true
  validates :parent, presence: true
end
