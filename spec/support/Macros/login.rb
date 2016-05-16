module Macros
  module Login
    # devise has a sign_in helper, it is not for use with integration tests
    # named this one different so its obviously not devise's
    def capy_sign_in(user)
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button 'Log in'
    end
  end
end





