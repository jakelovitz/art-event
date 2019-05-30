class SignupMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.signup_mailer.new_user.subject
  #
  def new_user(user)
    @user = user
    @greeting = "Hi, #{@user.full_name}"

    mail to: @user.email, subject: 'New User Registration'
  end

end
