class Like < ActiveRecord::Base
  include Dateable
  # TODO make activity feedable

  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :parent, polymorphic: true

  validates :creator, presence: true
  validates :parent, presence: true
  validates_uniqueness_of :parent_type, scope: [:parent_id, :user_id]
end
