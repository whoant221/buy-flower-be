class OrderPolicy < ApplicationPolicy
  def apply_voucher?
    @record.init?
  end

  def destroy?
    @record.init? || @record.pending?
  end
  
  def mark_as_pending?
    @record.init?
  end

  def mark_as_processing?
    @record.pending?
  end

  def mark_as_successful?
    @record.processing?
  end

  def mark_as_cancelled?
    @record.init? || @record.pending?
  end
end
