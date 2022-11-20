# Preview all emails at http://localhost:3000/rails/mailers/session_mailer
class SessionMailerPreview < ActionMailer::Preview
  def reset_password
    SessionMailer.with(user: User.first, new_password: '232323').reset_password
  end
end
