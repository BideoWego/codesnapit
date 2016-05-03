class SnapItsController < ApplicationController

  def index
  end


  def show
  end


  def new
    @snap_it_languages = SnapItLanguage.all
    @snap_it_themes = SnapItTheme.all
  end


  def create
  end


  def destroy
  end




  private
  def snap_it_params
    params.require(:snap_it).permit(
      :title,
      :description,
      :font_size,
      :image,
      :snap_it_language_id,
      :snap_it_theme_id
    )
  end
end




