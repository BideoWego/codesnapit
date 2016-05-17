class SearchController < ApplicationController

  def search
    @snap_its = SnapIt.search(params[:q])

    users = User.search(params[:q])
    profiles = Profile.search(params[:q])
    @users = User.where(id: (users.pluck(:id) + profiles.pluck(:user_id) ) )
  end

end