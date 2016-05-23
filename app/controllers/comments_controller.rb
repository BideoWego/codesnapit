class CommentsController < ApplicationController

  before_action :find_parent, only: [:index, :create]
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    respond_to do |format|
      format.json { render json: CommentsForApi.new(@parent.comments) }
    end
  end

  def create
    comment = current_user.comments.build(
      body: params[:body], 
      parent: @parent)

    respond_to do |format|
      if comment.save
        format.json { render json: CommentForApi.new(comment) }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    comment = current_user.comments.find_by_id(params[:id])

    respond_to do |format|    
      if comment && comment.destroy
        format.json { render json: CommentForApi.new(comment) }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end


  private


  def find_parent
    begin
      @parent = params[:parent_type]
                  .classify
                  .constantize
                  .find_by_id( params[:parent_id] )
    rescue NameError
      @parent = nil
    end

    unless @parent
      respond_to { |f| f.json { render nothing: true, status: :unprocessable_entity } }
      return
    end    
  end
  
end
