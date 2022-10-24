module Api
  module V1
    class SessionsController < ApiController
      def login
      end

      def register
        AuthenticateService::Register.new(params: user_params).create
      end

      private

      def user_params
        params.permit(:email, :password, :phone_number, :password_confirmation, :name, :address)
      end
    end
  end
end