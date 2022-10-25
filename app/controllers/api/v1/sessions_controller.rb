module Api
  module V1
    class SessionsController < ApiController
      def login
        authenticate = AuthenticateService::Login.new(email: user_params['email'], password: user_params['password'])
        if authenticate.success?
          render 'login', locals: {
            token: authenticate.token
          }, formats: [:json], status: :ok
        end
      rescue Constants::InvalidCredentials => e
        json_response({message: e.message}, :service_unavailable)
      end

      def register
        AuthenticateService::Register.new(params: user_params).create
      rescue Constants::UserExists => e
        json_response({message: e.message}, :unprocessable_entity)
      end

      private

      def user_params
        params.permit(:email, :password, :phone_number, :password_confirmation, :name, :address)
      end
    end
  end
end