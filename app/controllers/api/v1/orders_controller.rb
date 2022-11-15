module Api
  module V1
    class OrdersController < ApiController
      def create
        OrderService::Client.new(user: current_user).create(order_params, params[:data])
        render json: {}, status: :ok
      end

      def init_order
        render 'api/v1/orders/index', locals: {
          orders: order_service.filter_order(Order::INIT)
        }, formats: [:json], status: :ok
      end

      def pending_order
        render 'api/v1/orders/index', locals: {
          orders: order_service.filter_order(Order::PENDING)
        }, formats: [:json], status: :ok
      end

      def processing_order
        render 'api/v1/orders/index', locals: {
          orders: order_service.filter_order(Order::PROCESSING)
        }, formats: [:json], status: :ok
      end

      def successful_order
        render 'api/v1/orders/index', locals: {
          orders: order_service.filter_order(Order::SUCCESSFUL)
        }, formats: [:json], status: :ok
      end

      def cancelled_order
        render 'api/v1/orders/index', locals: {
          orders: order_service.filter_order(Order::CANCELLED)
        }, formats: [:json], status: :ok
      end

      def show
        render 'api/v1/orders/show', locals: {
          order: OrderService::Order.new(user: current_user, order_id: params[:id]).show
        }, formats: [:json], status: :ok
      end

      def destroy
        OrderService::Order.new(user: current_user, order_id: params[:id]).cancel
        render json: {}, status: :ok
      end

      private

      def order_service
        @order_service ||= OrderService::Client.new(user: current_user)
      end

      def order_params
        params.permit(:note, :receive_address)
      end
    end
  end
end
