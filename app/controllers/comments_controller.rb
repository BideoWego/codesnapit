class CommentsController < ApplicationController

  def index
    @parent = params[:parent_type]
                .classify
                .constantize
                .find_by_id( params[:parent_id] )

    respond_to do |format|
      format.json { render json: @parent.comments }
    end
  end

  def create
    parent = params[:parent_type]
                .classify
                .constantize
                .find_by_id( params[:parent_id] )

    @comment = current_user.comments.build(
      body: params[:body], 
      parent: parent)

    respond_to do |format|
      if @comment.save
        format.json { render json: @comment }
      end
    end
  end
  
end
