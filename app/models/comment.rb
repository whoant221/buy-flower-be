class Comment < ApplicationRecord
  belongs_to :flower
  belongs_to :user

  validates_presence_of :content
  validates_numericality_of :rank, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5
end
