module Api
  module Admin
    class UsersController < ApiController
      def index
        users = User.all

        render 'index', locals: {
          users: users
        }, formats: [:json], status: :ok
      end

      def create
        AuthenticateService::Register.new(params: user_params).create
      end

      private

      def user_params
        params.permit(:email, :password, :phone_number, :password_confirmation, :name, :address)
      end
    end
  end
end
