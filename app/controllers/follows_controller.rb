class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_following

  def create
    @follow = Follow.new(initiator: current_user, following: @following)
    if @follow.save
      flash[:success] = "You successfully followed #{@following.username}!"
      redirect_to user_profile_path(@following)
    else
      redirect_to :back, alert: "Oops. Could not follow #{@following.username}."
    end
  end


  def destroy
    @follow = Follow.find_by(initiator: current_user, following: @following)
    if @follow.destroy
      flash[:success] = "You successfully unfollowed #{@following.username}."
      redirect_to :back
    else
      redirect_to :back, alert: "Oops. Could not unfollow #{@following.username}"
    end
  end




  private
  def set_following
    collection = action_name == 'create' ? User : current_user.followings
    @following = collection.find_by_id(params[:following])
    unless @following
      flash[:error] = 'Could not find followed user'
      redirect_to :back
    end
  end
end


