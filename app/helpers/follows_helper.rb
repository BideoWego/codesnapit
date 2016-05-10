module FollowsHelper

  def follow_buttons(user)
    if current_user == user
      button_string = ''
    elsif current_user.following.include?(user)
      button_string = "#{link_to fa_icon('minus', text: 'Unfollow'), follow_path(following: @profile.user.id), method: :delete, class: 'btn btn-default'}"
    else
      button_string = "#{link_to fa_icon('plus', text: 'Follow'), follow_path(following: @profile.user.id), method: :post, class: 'btn btn-primary'}"
    end

    button_string.html_safe
  end
end
