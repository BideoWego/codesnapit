class SnapItsController < ApplicationController
  before_action :set_snap_it, :only => [:show, :destroy]

  def index
    @snap_its = current_user.snap_its
  end


  def show
  end


  def new
    @snap_it_languages = SnapItLanguage.all
    @snap_it_themes = SnapItTheme.all
  end


  def create
    @snap_it = current_user.snap_its.new_from_token(snap_it_params[:token])
    if @snap_it.save
      flash[:success] = 'SnapIt created'
      redirect_to snap_its_path
    else
      flash[:error] = 'SnapIt not created: ' +
        @snap_it.errors.full_messages.join(', ')
      redirect_to new_snap_it_path
    end
  end


  def destroy
    if @snap_it.destroy
      flash[:success] = 'SnapIt destroyed'
    else
      flash[:error] = 'SnapIt not destroyed' +
        @snap_it.errors.full_messages.join(', ')
    end
    redirect_to :back
  end




  private
  def set_snap_it
    collection = action_name == 'show' ? SnapIt : current_user.snap_its
    @snap_it = collection.find_by_id(params[:id])
    redirect_to :back, :flash => { :error => 'SnapIt not found' } unless @snap_it
  end


  def snap_it_params
    params.require(:snap_it).permit(
      :token
    )
  end
end




