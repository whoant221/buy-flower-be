class SessionMailer < ApplicationMailer
  default from: "vovanhoangtuan4.3@gmail.com"

  def reset_password
    @user = params[:user]
    @new_password = params[:new_password]
    mail(to: @user.email, subject: 'Cập nhập lại mật khẩu')
  end
end
