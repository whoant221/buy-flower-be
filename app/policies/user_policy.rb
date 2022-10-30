class UserPolicy < ApplicationPolicy
  def login?
    user.present?
  end
end

