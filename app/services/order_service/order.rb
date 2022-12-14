module OrderService
  class Order
    def initialize(order:, user:)
      @order = order
      @user = user
    end

    def apply_voucher(voucher_service)
      sale_price = voucher_service.sale_price(order.original_price)
      raise ActiveRecord::RecordNotFound, I18n.t('services.voucher_service.unconditional') if sale_price == 0
      ::Order.transaction do
        voucher_service.apply_order(order)
        order.sale_price = order.original_price - sale_price
        order.save!
      end
    end

    def cancel_order
      VoucherOrder.destroy_by(order_id: order.id)
      order.mark_as_cancelled
    end

    def mark_processing

    end

    private

    attr_accessor :order, :user

    def voucher_service
      @voucher_service ||= VoucherService::Client.new(code: code, user: user)
    end

  end
end
