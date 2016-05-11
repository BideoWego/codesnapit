class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    person_to_follow = User.find(params[:following])
    follow = Follow.new(initiator: current_user, following: person_to_follow)

    if follow.save
      flash[:success] = "You successfully followed #{person_to_follow.username}!"
      redirect_to user_profile_path(user_id: person_to_follow.id)
    else
      redirect_to :back, alert: "Oops. Could not follow #{person_to_follow.username}."
    end
  end

  def destroy
    person_to_unfollow = User.find(params[:following])
    follow = Follow.find_by(initiator: current_user, following: person_to_unfollow)

    if follow.destroy
      flash[:success] = "You successfully unfollowed #{person_to_unfollow.username}."
      redirect_to :back
    else
      redirect_to :back, alert: "Oops. Could not unfollow #{person_to_unfollow.username}"
    end
  end
end
