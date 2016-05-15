class Follow < ActiveRecord::Base
  belongs_to :initiator, foreign_key: :initiator_id, class_name: 'User'
  belongs_to :following, foreign_key: :following_id, class_name: 'User'

  validates_presence_of :initiator, :following
  validates_uniqueness_of :following_id, scope: :initiator_id
end


