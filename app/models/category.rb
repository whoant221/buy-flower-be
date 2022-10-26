class Category < ApplicationRecord
  has_many :flowers
  
  validates :title, uniqueness: true, presence: true
end
