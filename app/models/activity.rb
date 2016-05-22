class Activity < ActiveRecord::Base
  include Dateable

  belongs_to :user
  belongs_to :activity_feedable, :polymorphic => true

  def self.feed_for(user)
    Activity.where(
      'user_id IN (?) OR user_id = ?',
      user.followings.pluck(:id),
      user.id
    ).order(:created_at => :desc)
  end


  def self.timeline_for(user)
    where(:user_id => user.id).order(:created_at => :desc)
  end
end
