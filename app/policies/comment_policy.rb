class CommentPolicy < ApplicationPolicy
  def create?
    Order.joins(:order_details, :flower_details).where('flower_id = ?', @record.id).where('user_id = ?', @user.id).present?
  end
end

