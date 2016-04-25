class ProfilesController < ApplicationController

  def show
    @profile = User.find_by_id(params[:user_id]).profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
  end

end
