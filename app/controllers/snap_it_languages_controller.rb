class SnapItLanguagesController < ApplicationController
  def index
    @languages = SnapItLanguage.all
    respond_to do |format|
      format.json { render :json => @languages, :status => 200 }
    end
  end
end
