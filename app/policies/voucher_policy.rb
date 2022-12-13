class VoucherPolicy < ApplicationPolicy

  def destroy?
    @record.orders_count == 0
  end
end
