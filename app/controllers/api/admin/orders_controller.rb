module Api
  module Admin
    class OrdersController < ApiController
      before_action :order, only: [:mark_as_processing, :mark_as_successful, :mark_as_cancelled]

      def index
        render 'index', locals: {
          orders: Order.filter_by_state(params[:state])
        }, formats: [:json], status: :ok
      end

      def mark_as_processing
        authorize order, :mark_as_processing?
        TransportOrderJob.perform_later(order)

        render 'show', locals: {
          order: order
        }, formats: [:json], status: :ok
      end

      def mark_as_successful
        authorize order, :mark_as_successful?
        order.transaction do
          order.mark_as_successful
          current_user.increment!(:point, 10)
        end

        render 'show', locals: {
          order: order
        }, formats: [:json], status: :ok
      end

      def mark_as_cancelled
        authorize order, :mark_as_cancelled?
        order.mark_as_cancelled

        render 'show', locals: {
          order: order
        }, formats: [:json], status: :ok
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
