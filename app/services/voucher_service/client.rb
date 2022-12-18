module VoucherService
  class Client
    def initialize(code: nil, user:)
      @code = code
      @user = user
    end

    def valid_vouchers(price)
      result = Voucher.joins(:user_vouchers)
                      .where('user_vouchers.user': user)
                      .where('user_vouchers.state': UserVoucher::PENDING)
                      .where("effective_at <= ?", Time.now)
                      .where("expiration_at >= ?", Time.now)
      result = result.where("threshold <= ?", price) unless price.blank?

      result
    end

    def can_be_exchange
      Voucher.where("effective_at <= ?", Time.now)
             .where("expiration_at >= ?", Time.now)
             .where("orders_count < limit_count")
             .where.not(id: UserVoucher.where(user: user).select(:voucher_id))
    end

    def exchange
      raise Exceptions::NotEnoughPoint, I18n.t('services.voucher_service.not_enough_point') unless valid_point?
      raise Exceptions::ExchangeVoucherError, I18n.t('services.voucher_service.exchange_error') unless can_be_exchange?
      user.vouchers << voucher
    end

    def valid?(price)
      valid_use? && voucher.valid_condition?(price)
    end

    def sale_price(original_price)
      raise Exceptions::UseVoucherInvalid, I18n.t('services.voucher_service.invalid_use') unless valid_use?
      voucher.calculate_price(original_price)
    end

    def apply_order(order)
      raise Exceptions::UseVoucherInvalid, I18n.t('services.voucher_service.invalid_use') unless valid_use?

      voucher.orders << order
      user_voucher.mark_as_successful

    end

    private

    attr_accessor :user, :code

    def valid_point?
      user.point >= voucher.point
    end

    def valid_use?
      user_voucher.pending? && valid_time?
    end

    def valid_time?
      voucher.effective_at <= Time.now && voucher.expiration_at >= Time.now
    end

    def can_be_exchange?
      UserVoucher.where(voucher: voucher, user: user).count == 0 && voucher.orders_count < voucher.limit_count && valid_time?
    end

    def user_voucher
      @user_voucher = UserVoucher.find_by(voucher: voucher, user: user)
      raise ActiveRecord::RecordNotFound, I18n.t('services.voucher_service.not_exists') unless @user_voucher

      @user_voucher
    end

    def voucher
      @voucher = Voucher.find_by_code(code)
      raise ActiveRecord::RecordNotFound, I18n.t('services.voucher_service.not_exists') unless @voucher

      @voucher
    end

  end
end
