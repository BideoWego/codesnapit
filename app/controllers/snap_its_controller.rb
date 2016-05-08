class SnapItsController < ApplicationController

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
    @snap_it = SnapIt.new_from_token(snap_it_params[:token])
    if @snap_it.save
      flash[:success] = 'SnapIt created'
    else
      flash[:error] = 'SnapIt not created: ' +
        @snap_it.errors.full_messages.join(', ')
    end
    redirect_to root_path
  end


  def destroy
  end




  private
  def snap_it_params
    params.require(:snap_it).permit(
      :token
    )
  end
end




