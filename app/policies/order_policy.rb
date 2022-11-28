class OrderPolicy < ApplicationPolicy

  def destroy?
    @record.pending?
  end

  def mark_as_processing?
    @record.pending?
  end

  def mark_as_successful?
    @record.processing?
  end

  def mark_as_cancelled?
    @record.pending?
  end
end
