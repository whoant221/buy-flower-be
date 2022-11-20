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

  scope :find_color, -> (color) { find_by(color: color) if color.present? }

  scope :find_price, -> (price) { where("originalPrice <= ?", price) if price.present? }

  scope :find_name, -> (name) { where("name LIKE ?", name) if name.present? }

  def remaining_amount
    flower_details.sum('count - used_count')
  end

end
