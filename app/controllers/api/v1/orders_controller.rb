module Api
  module V1
    class OrdersController < ApiController
      before_action :required_login

      def index
        render 'api/v1/orders/index', locals: {
          orders: filter_order(params[:state])
        }, formats: [:json], status: :ok
      end

      def create
        OrderService::Client.new(user: current_user).create(order_params)
        render json: {}, status: :ok
      end

      def show
        render 'api/v1/orders/show', locals: {
          order: order
        }, formats: [:json], status: :ok
      end

      def valid_voucher
        authorize order, :valid_voucher?
        sale_price = order_service.calculate_price_from_voucher(params[:code])
        render json: {
          sale_price: sale_price
        }, status: :ok
      end

      def apply_voucher
        authorize order, :apply_voucher?
        order_service.apply_voucher(params[:code])
      end

      def destroy
        authorize order, :destroy?
        order_service.cancel
        render json: {}, status: :ok
      end

      def transaction_as_pending
        authorize order, :transaction_as_pending?
        order_service.transaction_as_pending
        render json: {}, status: :ok
      end

      def transaction_as_processing
        authorize order, :transaction_as_processing?
        order_service.transaction_as_processing
        render json: {}, status: :ok
      end

      private

      def filter_order(state)
        return current_user.orders if state.nil?
        current_user.orders.where(state: state)
      end

      def order_service
        @order_service ||= OrderService::Order.new(order: order)
      end

      def order_params
        params.permit(:note, :receive_address)
      end

      def order
        @order ||= Order.find_by(user: current_user, id: params[:id])
        raise ActiveRecord::RecordNotFound, I18n.t('controller.concerns.api.v1.order.not_exists') unless @order

        @order
      end
    end
  end
end
