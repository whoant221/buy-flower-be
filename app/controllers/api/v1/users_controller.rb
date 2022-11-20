module Api
  module V1
    class UsersController < ApiController
      before_action :required_login

      def index
        render 'index', locals: {
          user: current_user
        }, formats: [:json], status: :ok
      end

      def change_info
        UserService::Client.new(user: current_user).update(user_params)
        render json: {}, status: :ok
      end

      private

      def user_params
        params.permit(:password, :phone_number, :password_confirmation, :name, :address)
      end

    end
  end
end
