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

end
