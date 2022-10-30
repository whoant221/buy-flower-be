class ShoppingCartPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  private
end

