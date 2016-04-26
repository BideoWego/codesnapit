class ProfilesController < ApplicationController

  def show
    @profile = User.find_by_id(params[:user_id]).profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if @profile.update(profile_params)
      flash[:success] = "Profile Updated"
      redirect_to user_profile_path(@profile.user)
    else
      flash[:danger] = "Oops, something went wrong!"
      render :edit
    end
  end


  private


  def profile_params
    params.require(:profile).permit(:full_name, :website, :bio, :avatar)    
  end

end
