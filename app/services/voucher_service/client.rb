module VoucherService
  class Client
    def initialize(code: nil, user:)
      @code = code
      @user = user
    end

    def valid_vouchers(price)
      result = Voucher.where("effective_at <= ?", Time.now)
                      .where("expiration_at >= ?", Time.now)
                      .where("limit_count > orders_count")
                      .where.not(id: VoucherOrder.joins(:order).where("order.user": user).select(:voucher_id))

      result = result.where("threshold <= ?", price) unless price.blank?
      result
    end

    def valid?(price)
      voucher.valid_condition?(price)
    end

    def sale_price(original_price)
      voucher.calculate_price(original_price)
    end

    def apply_order(order)
      voucher.orders << order
    end

    private

    attr_accessor :user, :code

    def voucher
      @voucher = Voucher.find_by(code: code)
      raise ActiveRecord::RecordNotFound, I18n.t('services.voucher_service.not_exists') unless @voucher

      @voucher
    end

  end
end
