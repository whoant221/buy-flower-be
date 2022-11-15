module OrderService
  class Order
    def initialize(user:, order_id:)
      @user = user
      @order_id = order_id
    end

    def show
      order
    end

    def cancel
      raise Exceptions::OrderInvalid, I18n.t('services.order_service.cannot_cancel') unless order.init? || order.pending?
      order.update(state: ::Order::CANCELLED)
      true
    end

    private

    def order
      @order ||= @user.orders.find_by(id: @order_id)
      raise ActiveRecord::RecordNotFound, I18n.t('services.order_service.not_exists') unless @order

      @order
    end

  end
end
