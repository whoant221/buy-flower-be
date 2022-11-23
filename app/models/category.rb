class Category < ApplicationRecord
  has_many :category_flowers
  has_many :flowers, through: :category_flowers

  validates :title, uniqueness: true, presence: true

  scope :search, -> (title) {
    result = all
    result = result.where("title ILIKE ?", "%#{title}%") if title.present?

    result
  }

end
