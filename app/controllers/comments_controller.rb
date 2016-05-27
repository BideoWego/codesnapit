class CommentsController < ApplicationController
  before_action :find_parent, only: [:index, :create]
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    respond_to do |format|
      format.json { render json: @parent.comments.map { |comment| CommentForApi.new(comment, view_context) } }
    end
  end

  def create
    comment = current_user.comments.build(
      body: params[:body], 
      parent: @parent)

    respond_to do |format|
      if comment.save
        format.json { render json: CommentForApi.new(comment, view_context) }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    comment = current_user.comments.find_by_id(params[:id])

    respond_to do |format|    
      if comment && comment.destroy
        format.json { render json: CommentForApi.new(comment, view_context) }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end
  
end
