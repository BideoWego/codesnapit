class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true

  validates :tag,
            :presence => true

  validates :taggable,
            :presence => true

  validates :tag_id,
            :uniqueness => { :scope => [:taggable_id, :taggable_type] }
end
