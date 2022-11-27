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
        if order_params[:delivery_time].blank? || order_params[:delivery_time].to_datetime <= Date.today
          raise Exceptions::TimeInvalid, I18n.t('services.order_service.time_invalid')
        end

        if params[:receiver].blank? || params[:receive_phone].blank? || params[:gift_cart_for].blank? || params[:reason].blank? || params[:message].blank?
          raise Exceptions::DataInvalid, I18n.t('services.order_service.data_invalid')
        end
        additional_data = {
          :receiver => params[:receiver],
          :receive_phone => params[:receive_phone],
          :gift_cart_for => params[:gift_cart_for],
          :reason => params[:reason],
          :message => params[:message],
        }
        order = OrderService::Client.new(user: current_user).create(order_params, additional_data)
        if params[:code].present? && order.present?
          OrderService::Order.new(order: order).apply_voucher(params[:code])
        end
        render 'show', locals: {
          order: order
        }, formats: [:json], status: :ok
      end

      def show
        render 'show', locals: {
          order: order
        }, formats: [:json], status: :ok
      end

      def destroy
        authorize order, :destroy?
        order_service.cancel_order
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
        params.permit(:note, :receive_address, :delivery_time)
      end

      def order
        @order ||= Order.find_by(user: current_user, id: params[:id])
        raise ActiveRecord::RecordNotFound, I18n.t('controller.concerns.api.v1.order.not_exists') unless @order

        @order
      end
    end
  end
end
