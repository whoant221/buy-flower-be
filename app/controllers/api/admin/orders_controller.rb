module Api
  module Admin
    class OrdersController < ApiController
      before_action :order, only: [:transaction_as_success]

      def index
        render 'index', locals: {
          orders: Order.search(params[:state])
        }, formats: [:json], status: :ok
      end

      def transaction_as_successful
        authorize order, :transaction_as_successful?
        order.mark_as_successful
        render json: {}, status: :ok
      end

      def transaction_as_cancelled
        authorize order, :transaction_as_cancelled?
        order.mark_as_cancelled
        render json: {}, status: :ok
      end

      private

      def order
        @order ||= Order.find_by(id: params[:id])
        raise ActiveRecord::RecordNotFound, I18n.t('controller.concerns.api.v1.order.not_exists') unless @order

        @order
      end
    end
  end
end