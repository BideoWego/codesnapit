class ScreenshotsController < ApplicationController
  def create
    data = Screenshot.capture(params[:url])
    respond_to do |format|
      format.json { render :json => data.to_json , :status => 201 }
    end
  end
end
