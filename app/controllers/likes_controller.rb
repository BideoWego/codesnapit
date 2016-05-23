class LikesController < ApplicationController

  before_action :find_parent, only: [:index, :create]
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    respond_to do |format|
      format.json { render json: @parent.likes }
    end
  end

  def create
    like = current_user.likes.build(parent: @parent)

    respond_to do |format|
      if like.save
        format.json { render json: like }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    like = current_user.likes.find_by_id(params[:id])

    respond_to do |format|    
      if like && like.destroy
        format.json { render json: like }
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
