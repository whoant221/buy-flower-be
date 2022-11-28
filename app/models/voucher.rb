class Voucher < ApplicationRecord
  has_many :voucher_orders
  has_many :orders, through: :voucher_orders

  before_validation :set_default_values

  validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates_uniqueness_of :code
  validates_presence_of :content, :effective_at, :expiration_at
  validates_numericality_of :limit_count, :threshold, :max_amount, :greater_than_or_equal_to => 0

  scope :filter_valid, -> (price) {
    result = where("effective_at <= ?", Time.now).where("expiration_at >= ?", Time.now).where("limit_count > orders_count")
    result = result.where("threshold <= ?", price) if price.present?
    result
  }

  scope :invalid, -> () { where("effective_at > ?", Time.now).or(where("expiration_at < ?", Time.now)).or(where("limit_count <= orders_count")) }

  def valid_condition?(price)
    orders_count < limit_count && effective_at <= Time.now && expiration_at >= Time.now && price >= threshold
  end

  def calculate_price(price)
    if valid_condition?(price)
      return max_amount if discount == 0
      sale_price = price * discount / 100
      return sale_price if max_amount == 0
      return max_amount if sale_price > max_amount
      sale_price
    end
    0
  end

  def render_condition
    if threshold == 0
      return "Sẽ nhận được giảm giá #{max_amount}" if discount == 0
      return "Sẽ nhận được giảm giá #{discount}%" if max_amount == 0
      "Sẽ nhận được giảm giá #{discount}%, không vượt quá #{max_amount}đ"
    else
      return "Đơn hàng trị giá trên #{threshold}đ sẽ nhận được giảm giá #{max_amount}" if discount == 0
      return "Đơn hàng trị giá trên #{threshold}đ sẽ nhận được giảm giá #{discount}%" if max_amount == 0
      "Đơn hàng trị giá trên #{threshold}đ sẽ nhận được giảm giá #{discount}%, không vượt quá #{max_amount}đ"
    end
  end

  private

  def set_default_values
    self.orders_count = 0
  end

end
