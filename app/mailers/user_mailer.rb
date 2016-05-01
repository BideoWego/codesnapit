class UserMailer < Devise::Mailer
  # This mailer is used in place of Devise's default mailer
  # Example "welcome" method left below for reference

  default from: "noreply@codesnapit.com"
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  # Handled by Devise.
  # def welcome(user_id)
  #   @user = User.find_by_id(user_id)
  #   mail(to: user.email, subject: 'Wecome to CodeSnapIt')
  # end

end
