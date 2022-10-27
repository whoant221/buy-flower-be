class ShoppingCart < ApplicationRecord
  belongs_to :user
  belongs_to :flower

  validates_numericality_of :amount, :greater_than_or_equal_to => 1
end
