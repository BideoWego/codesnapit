module ControllerHelper
  def render_404
    render_template(:file => "#{Rails.root}/public/404.html")
  end


  def render_422
    render_template(:file => "#{Rails.root}/public/422.html")
  end


  def render_500
    render_template(:file => "#{Rails.root}/public/500.html")
  end


  def flash_error
    flash[:alert] || flash[:error] || flash[:danger]
  end


  def flash_success
    flash[:success]
  end


  def flash_warning
    flash[:warn] || flash[:warning]
  end


  def flash_info
    flash[:notice] || flash[:info]
  end
end






