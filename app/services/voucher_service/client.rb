module VoucherService
  class Client
    def initialize(code:)
      @code = code;
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

    def voucher
      @voucher = Voucher.find_by(code: @code)
      raise ActiveRecord::RecordNotFound, I18n.t('services.voucher_service.not_exists') unless @voucher

      @voucher
    end

  end
end
