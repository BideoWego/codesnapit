class TagsController < ApplicationController
  def index
    @tags = Tag.pluck(:name)
    respond_to do |format|
      format.json { render :json => @tags, :status => 200 }
    end
  end
end
