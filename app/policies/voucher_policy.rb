class VoucherPolicy < ApplicationPolicy

  def destroy?
    @record.orders_count == 0
  end

  def exchange?
    UserVoucher.where(voucher: @record).count == 0 &&
      @record.orders_count < @record.limit_count &&
      @record.effective_at <= Time.now &&
      @record.expiration_at >= Time.now
  end
end
