module Api
  module Admin
    class UsersController < ApiController
      def index
        users = User.search(params[:email])

        render 'index', locals: {
          users: users
        }, formats: [:json], status: :ok
      end

      def create
        AuthenticateService::Register.new(params: user_params).create
        render json: {}, status: :created
      end

      def update
        UserService::Client.new(user: user).update(user_params)
        render json: {}, status: :ok
      end

      private

      def user
        @user ||= User.find_by_id(params[:id])
        raise ActiveRecord::RecordNotFound, I18n.t('services.user_service.not_exists') unless @user

        @user
      end

      def user_params
        params.permit(:email, :password, :phone_number, :password_confirmation, :name, :address)
      end
    end
  end
end
