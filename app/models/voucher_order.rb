class VoucherOrder < ApplicationRecord
  belongs_to :voucher, :counter_cache => :orders_count
  belongs_to :order

end
