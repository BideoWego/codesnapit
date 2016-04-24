module LoginMacros
  def sign_in(user)
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button 'Log in'
  end

  # def sign_out
  #   visit root_path
  #   click_link "Logout"
  # end
end