class VoucherOrder < ApplicationRecord
  belongs_to :voucher
  belongs_to :order

end
