module OrderService
  class Order
    def initialize(order:)
      @order = order
    end

    def calculate_price_from_voucher(code)
      VoucherService::Client.new(code: code).sale_price(order.original_price)
    end

    def apply_voucher(code)
      voucher_service = VoucherService::Client.new(code: code)
      sale_price = voucher_service.sale_price(order.original_price)
      raise ActiveRecord::RecordInvalid, I18n.t('services.voucher_service.unconditional') if sale_price == 0
      ::Order.transaction do
        voucher_service.apply_order(order)
        order.sale_price = order.original_price - sale_price
        order.state = ::Order::PENDING
        order.save!
      end
    end

    def cancel
      # raise Exceptions::OrderInvalid, I18n.t('services.order_service.cannot_cancel') unless order.init? || order.pending?
      VoucherOrder.destroy_by(order_id: order.id)
      mark_cancelled
    end

    private

    attr_accessor :order

    def mark_cancelled
      order.update(state: ::Order::CANCELLED)
    end

  end
end
