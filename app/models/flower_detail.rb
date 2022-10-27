class FlowerDetail < ApplicationRecord
  belongs_to :flower

  validates_presence_of :count, :used_count, :expiration_at
  validates_numericality_of :count, :greater_than => 0
  validates_numericality_of :used_count, :greater_than_or_equal_to => 0

  validate :expiration_at_cannot_less_or_equal_than_current
  validate :used_count_cannot_greater_than_count

  private

  def expiration_at_cannot_less_or_equal_than_current
    errors.add(:expiration_at, :less_or_equal_than_current) if expiration_at <= Date.today
  end

  def used_count_cannot_greater_than_count
    errors.add(:used_count, :greater_than_count) if used_count > count
  end

end
