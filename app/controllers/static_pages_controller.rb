class StaticPagesController < ApplicationController
  def index
    @snap_its = SnapIt.last(100).sample(3)
  end
end
