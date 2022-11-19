class OrderPolicy < ApplicationPolicy
  def apply_voucher?
    @record.init?
  end

  def destroy?
    @record.init? || @record.pending?
  end

  def valid_voucher?
    @record.init?
  end
end
