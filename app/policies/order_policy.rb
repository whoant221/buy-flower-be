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

  def transaction_as_pending?
    @record.init?
  end

  def transaction_as_processing?
    @record.pending?
  end

  def transaction_as_successful?
    @record.processing?
  end

  def transaction_as_cancelled?
    @record.init?
  end
end
