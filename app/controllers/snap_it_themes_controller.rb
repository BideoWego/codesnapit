class SnapItThemesController < ApplicationController
  def index
    @themes = SnapItTheme.all
    respond_to do |format|
      format.json { render :json => @themes, :status => 200 }
    end
  end
end
