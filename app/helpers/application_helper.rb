module ApplicationHelper
  def site_title
    'CodeSnapIt'
  end


  def tagline
    'Your code is beautiful, share it.'
  end


  def flash_css_class(key)
    if ['notice', 'error'].include?(key)
      key == 'notice' ? 'info' : 'danger'
    else
      key.to_s
    end
  end
end
