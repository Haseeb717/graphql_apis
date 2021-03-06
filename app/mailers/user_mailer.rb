class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot_password.subject
  #
  def forgot_password(user)
	  @user = user
	  @greeting = "Hi"
	  
	  mail to: user.email, :subject => 'Reset password instructions'
	end

  def verification_email(user)
    @user = user
    @greeting = "Hi"
    
    mail to: user.email, :subject => 'Reset verification email'
  end
end
