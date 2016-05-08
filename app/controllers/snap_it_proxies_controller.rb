class SnapItProxiesController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_snap_it_proxy, :only => [:show]

  layout 'empty'

  def show
  end


  def create
    @snap_it_proxy = current_user.snap_it_proxies.build(snap_it_proxy_params)
    respond_to do |format|
      if @snap_it_proxy.save
        @snap_it_proxy.create_image_data
        format.json { render :json => @snap_it_proxy, :status => 201 }
      else
        format.json { render :json => snap_it_proxy_errors, :status => 422 }
      end
    end
  end




  private
  def set_snap_it_proxy
    @snap_it_proxy = SnapItProxy.find_by_token(params[:token])

    unless @snap_it_proxy
      redirect_to '/404'
    end
  end

  def snap_it_proxy_params
    params.require(:snap_it_proxy).permit(
      :title,
      :description,
      :font_size,
      :body,
      :snap_it_language_id,
      :snap_it_theme_id
    )
  end


  def snap_it_proxy_errors
    if @snap_it_proxy
      error = @snap_it_proxy
        .errors
        .full_messages
    else
      error = resource_errors
    end
    { :error => error }
  end
end
