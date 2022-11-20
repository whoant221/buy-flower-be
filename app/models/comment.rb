class Comment < ApplicationRecord
  belongs_to :flower
  belongs_to :user
end
