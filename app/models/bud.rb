class Bud < ApplicationRecord

  has_many :flower_buds
  has_many :flowers, through: :flower_buds

  validates_uniqueness_of :name
  validates_numericality_of :count, :greater_than => 0

  scope :find_name, -> (name) { where("name ILIKE ?", "%#{name}%") if name.present? }

end
