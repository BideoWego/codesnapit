module FollowsHelper

  def follow_buttons(user)
    button_string = ''

    if user_signed_in?
      if current_user == user
      elsif current_user.following.include?(user)
        button_string = "#{link_to 'Following', follow_path(following: user.id), method: :delete, class: 'btn btn-primary following-button'}"
      else
        button_string = "#{link_to fa_icon('plus', text: 'Follow'), follow_path(following: user.id), method: :post, class: 'btn btn-default'}"
      end
    end

    button_string.html_safe
  end
end
