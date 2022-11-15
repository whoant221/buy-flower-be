class OrderPolicy < ApplicationPolicy
  def cancel?
    @record.init? || @record.pending?
  end
end
