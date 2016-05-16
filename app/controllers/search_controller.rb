class SearchController < ApplicationController

  def search
    @results = SnapIt.search(params[:query])
  end

end