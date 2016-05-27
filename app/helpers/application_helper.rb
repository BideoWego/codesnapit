module ApplicationHelper
  def site_title
    'CodeSnapIt'
  end


  def tagline
    'Your code is beautiful, share it.'
  end


  def logo_url(style=:normal)
    style = {
      :normal => '',
      :white => '-white'
    }[style]
    "#{root_url}images/logo#{style}.svg"
  end


  def flash_css_class(key)
    {
      'notice' => 'info',
      'error' => 'danger',
      'alert' => 'danger'
    }[key] || key.to_s
  end


  def present(object, klass=nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
  end
end
