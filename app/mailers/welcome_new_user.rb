class WelcomeNewUser < ActionMailer::Base
  default from: 'Manish Rawat <manishrawat0212@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_new_user.created.subject
  #
  def created(user)
    @user = user

    mail to: user.email, subject: "Welcome"
  end
end
