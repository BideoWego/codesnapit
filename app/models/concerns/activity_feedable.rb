module ActivityFeedable
  extend ActiveSupport::Concern

  included do
    has_many :activities, :as => :activity_feedable, :dependent => :destroy

    after_create :activity_feedable_created
    after_update :activity_feedable_updated
    after_destroy :activity_feedable_destroyed
  end


  def activity_feedable_created
    create_activity(:create)
  end


  def activity_feedable_updated
    create_activity(:update)
  end


  def activity_feedable_destroyed
    create_activity(:destroy)
  end


  def create_activity(verb)
    if self.class.activity_feedable_actions.include?(verb) &&
       
      methods = self.class.activity_feedable_user_methods
      methods.each do |method|
        Activity.create!(
          :user => self.send(method),
          :activity_feedable => self,
          :verb => verb
        )
      end
    end
  end


  class_methods do
    def activity_feedable_user_methods(*methods)
      @activity_feedable_user_methods = methods if methods.present?
      @activity_feedable_user_methods
    end


    def activity_feedable_actions(*actions)
      @activity_feedable_actions = actions if actions.present?
      @activity_feedable_actions
    end
  end
end


