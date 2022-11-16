class Category < ApplicationRecord
  has_many :category_flowers
  has_many :flowers, through: :category_flowers

  validates :title, uniqueness: true, presence: true
end
