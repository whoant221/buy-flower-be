module Api
  module V1
    class ShoppingCartsController < ApiController
      before_action :required_login

      def index
        shopping_carts = shopping_cart_service.all_items

        render 'api/v1/shopping_carts/index', locals: {
          shopping_carts: shopping_carts
        }, formats: [:json], status: :ok
      end

      def create
        shopping_cart = shopping_cart_service.add_item

        render 'api/v1/shopping_carts/create', locals: {
          shopping_cart: shopping_cart
        }, formats: [:json], status: :ok
      end

      def destroy
        shopping_cart_service.destroy(params[:id])

        render json: {}, status: :ok
      end

      private

      def shopping_cart_service
        @shopping_cart_service ||= ShoppingCartService::Client.new(user: current_user, params: shopping_cart_params)
      end

      def shopping_cart_params
        params.permit(:flower_id, :amount)
      end
    end
  end
end
