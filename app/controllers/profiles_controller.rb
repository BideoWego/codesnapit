class ProfilesController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :update]

  def show
    user = User.find_by_slug(params[:id])

    if user
      @profile = User.find_by_slug(params[:id]).profile
    else
      flash[:warning] = "Oops, I can't find that user!"
      redirect_to root_path
      return
    end

  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if params[:use_gravatar]
      @profile.gravatar = true
      @profile.save
      flash[:info] = "Gravatar selected"
    elsif params[:disable_gravatar]
      @profile.gravatar = false
      @profile.save
      flash[:info] = "Uploaded or Default avatar selected"
    elsif params[:remove_avatar]
      @profile.gravatar = false
      @profile.avatar = nil
      @profile.save
      flash[:info] = "Avatar removed"
    end

    if @profile.update(profile_params)
      flash[:success] = "Profile Updated"
      redirect_to edit_profile_path
    else
      flash.now[:danger] = "Oops, something went wrong!"
      render :edit
    end

  end


  private


  def profile_params
    params.require(:profile).permit(
      :full_name, 
      :website, 
      :bio, 
      :avatar
    )    
  end

end
