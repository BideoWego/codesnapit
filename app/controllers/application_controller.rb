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


  def redirect_to_back(a=nil, b={})
    path = a.is_a?(String) ? a : root_path
    options = a.is_a?(Hash) ? a : b
    if request.env["HTTP_REFERER"].present? &&
       request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to(:back, options)
    else
      redirect_to(path, options)
    end
  end


  def resource_errors
    [
      flash.now[:error],
      flash[:error],
      'An error has occurred while processing your request'
    ].compact.first
  end
end
