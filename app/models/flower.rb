class Flower < ApplicationRecord
  has_many :category_flowers
  has_many :category, through: :category_flowers

  has_many :shopping_carts

  has_many :users, through: :shopping_carts
  has_many :flower_details

  COLORS = [
    RED = 'red',
    BLUE = 'blue',
  ].freeze

  validates :color, inclusion: { in: COLORS }
  validates_uniqueness_of :name
  validates_presence_of :name, :sale_price, :original_price

  validates_numericality_of :sale_price, :original_price, :greater_than_or_equal_to => 0

  scope :search, -> (color, price, name) {
    result = all
    result = result.where(color: color) if color.present?
    result = result.where("original_price <= ?", price) if price.present?
    result = result.where("name LIKE ?", "%#{name}%") if name.present?
    result
  }

  def remaining_amount
    flower_details.sum('count - used_count')
  end

end
