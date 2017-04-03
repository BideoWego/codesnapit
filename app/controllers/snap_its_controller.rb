class SnapItsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :new]
  before_action :set_snap_it, :only => [:show, :destroy]


  def show
  end


  def new
    @font_sizes = SnapItProxy::FONT_SIZES
    @snap_it_languages = SnapItLanguage.all
    @snap_it_themes = SnapItTheme.all
  end


  def create
    @snap_it = current_user.snap_its.new_from_token(snap_it_params[:token])
    if @snap_it.save
      flash[:success] = 'SnapIt created'
      redirect_to @snap_it
    else
      flash[:error] = [
        'SnapIt not created ',
        '(likely because no source data was provided): ',
        @snap_it.errors.full_messages.join(', ')
      ].join
      redirect_to new_snap_it_path
    end
  end


  def destroy
    if @snap_it.destroy
      flash[:success] = 'SnapIt destroyed'
      redirect_to user_profile_path(current_user)
    else
      flash[:error] = 'SnapIt not destroyed' +
        @snap_it.errors.full_messages.join(', ')
      redirect_to_back
    end
  end




  private
  def set_snap_it
    collection = action_name == 'show' ? SnapIt : current_user.snap_its
    @snap_it = collection.find_by_id(params[:id])
    redirect_to_back :flash => { :error => 'SnapIt not found' } unless @snap_it
  end


  def snap_it_params
    params.require(:snap_it).permit(
      :token
    )
  end
end




