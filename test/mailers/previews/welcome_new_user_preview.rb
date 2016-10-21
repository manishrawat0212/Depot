# Preview all emails at http://localhost:3000/rails/mailers/welcome_new_user
class WelcomeNewUserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcome_new_user/created
  def created
    WelcomeNewUser.created
  end

end
