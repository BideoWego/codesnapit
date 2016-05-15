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
end






