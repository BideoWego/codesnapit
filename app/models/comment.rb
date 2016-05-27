class Comment < ActiveRecord::Base
  include Dateable
  include Taggable
  # TODO make activity feedable

  taggable_fields :body

  default_scope { order('created_at ASC') }

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :parent, polymorphic: true
  has_many :likes, as: :parent, dependent: :destroy
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings

  validates :body, length: {in: 4..512}, presence: true
  validates :author, presence: true
  validates :parent, presence: true
end
