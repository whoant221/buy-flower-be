module Api
  module V1
    class SessionsController < ApiController

      def login
        authenticate = AuthenticateService::Login.new(email: user_params[:email], password: user_params[:password])

        if authenticate.success?
          render 'login', locals: {
            token: authenticate.token,
            user: authenticate.user
          }, formats: [:json], status: :ok
        end
      end

      def register
        AuthenticateService::Register.new(params: user_params).create
      end

      def reset_password
        user = User.find_by(email: user_params[:email])
        raise ActiveRecord::RecordNotFound, I18n.t('controller.concerns.api.v1.render_concern.invalid_user') unless user

        new_password = SecureRandom.alphanumeric(10)
        user.update!(password: new_password, password_confirmation: new_password)
        SessionMailer.with(user: user, new_password: new_password).reset_password.deliver_later
      end

      private

      def user_params
        params.permit(:email, :password, :phone_number, :password_confirmation, :name, :address)
      end
    end
  end
end