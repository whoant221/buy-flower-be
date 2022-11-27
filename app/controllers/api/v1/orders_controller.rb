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
        order = OrderService::Client.new(user: current_user).create(order_params)
        if params[:code].present? && order.present?
          OrderService::Order.new(order: order).apply_voucher(params[:code])
        end
        render json: {}, status: :ok
      end

      def show
        render 'api/v1/orders/show', locals: {
          order: order
        }, formats: [:json], status: :ok
      end

      def valid_voucher
        sale_price = VoucherService::Client.new(code: params[:code]).sale_price(params[:price])
        render json: {
          sale_price: sale_price
        }, status: :ok
      end

      # def apply_voucher
      #   authorize order, :apply_voucher?
      #   order_service.apply_voucher(params[:code])
      #   render json: {}, status: :ok
      # end

      def destroy
        authorize order, :destroy?
        order_service.cancel_order
        render json: {}, status: :ok
      end

      def mark_as_pending
        authorize order, :mark_as_pending?
        order.mark_as_pending
        render json: {}, status: :ok
      end

      def mark_as_processing
        authorize order, :mark_as_processing?
        order.mark_as_processing
        render json: {}, status: :ok
      end

      def mark_as_cancelled
        authorize order, :mark_as_cancelled?
        order.mark_as_cancelled
        render json: {}, status: :ok
      end

      private

      def filter_order(state)
        return current_user.orders if state.nil?
        current_user.orders.where(state: state).orders
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
