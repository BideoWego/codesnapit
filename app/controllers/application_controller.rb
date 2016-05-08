class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def resource_errors
    [
      flash.now[:error],
      flash[:error],
      'An error has occurred while processing your request'
    ].compact.first
  end
end
