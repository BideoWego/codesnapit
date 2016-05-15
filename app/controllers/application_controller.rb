class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def render_404
    render :file => 'public/404.html', :status => 404, :layout => false
  end


  def render_422
    render :file => 'public/422.html', :status => 422, :layout => false
  end


  def render_500
    render :file => 'public/500.html', :status => 500, :layout => false
  end


  def resource_errors
    [
      flash.now[:error],
      flash[:error],
      'An error has occurred while processing your request'
    ].compact.first
  end
end
