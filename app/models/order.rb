class Order < ApplicationRecord
  STATES = [
    PENDING = 'pending',
    PROCESSING = 'processing',
    SUCCESSFUL = 'successful',
    CANCELLED = 'cancelled',
  ].freeze

  belongs_to :user
  has_many :order_details
  has_many :flowers, through: :order_details

  has_many :voucher_orders
  has_many :vouchers, through: :voucher_orders

  before_validation :set_default_values

  validates_presence_of :receive_address

  scope :filter_by_state, -> (state) {
    result = all
    result = result.where("state = ?", state) if state.present?
    result.order(created_at: :desc)
  }

  def price
    order_details.sum('amount * price')
  end

  STATES.each do |state|
    define_method "mark_as_#{state}" do
      update!(state: state)
    end
    define_method "#{state}?" do
      self.state == state
    end
  end

  def set_default_values
    self.sale_price ||= original_price
    self.state ||= PENDING
  end

end
