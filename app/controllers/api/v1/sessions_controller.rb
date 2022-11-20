module Api
  module V1
    class SessionsController < ApiController
      before_action :required_login, only: [:me]

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

      def me
        render 'me', locals: {
          user: current_user
        }, formats: [:json], status: :ok
      end

      private

      def user_params
        params.permit(:email, :password, :phone_number, :password_confirmation, :name, :address)
      end
    end
  end
end