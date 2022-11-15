class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :flower_detail
end
