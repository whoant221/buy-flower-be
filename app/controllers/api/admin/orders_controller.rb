module Api
  module Admin
    class OrdersController < ApiController
      before_action :order, only: [:mark_as_successful, :mark_as_cancelled]

      def index
        render 'index', locals: {
          orders: Order.search(params[:state])
        }, formats: [:json], status: :ok
      end

      def mark_as_successful
        authorize order, :mark_as_successful?
        order.mark_as_successful

        render json: {}, status: :ok
      end

      def mark_as_cancelled
        authorize order, :mark_as_cancelled?
        order.mark_as_cancelled

        render json: {}, status: :ok
      end

      private

      def order_service
        @order_service ||= OrderService::Order.new(order: order)
      end

      def order
        @order ||= Order.find_by(id: params[:id])
        raise ActiveRecord::RecordNotFound, I18n.t('controller.concerns.api.v1.order.not_exists') unless @order

        @order
      end
    end
  end
end