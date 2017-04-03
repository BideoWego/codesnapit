class SearchController < ApplicationController

  def search
    if !params[:q] || params[:q].length < 1
      flash[:warning] = 
        "Please enter a longer search term"
      redirect_to_back
    else
      @snap_its = SnapIt
        .search(params[:q])
        .paginate(page: params[:page], per_page: 20)

      users = User.search(params[:q])
      profiles = Profile.search(params[:q])
      @users = User
        .where( id: (users.pluck(:id) + profiles.pluck(:user_id) ) )
        .paginate(page: params[:page], per_page: 20)
    end
  end

end