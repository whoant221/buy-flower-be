class Order < ApplicationRecord
  STATES = [
    INIT = 'init',
    PENDING = 'pending',
    PROCESSING = 'processing',
    SUCCESSFUL = 'successful',
    CANCELLED = 'cancelled',
  ].freeze

  belongs_to :user
  has_many :order_details
  has_many :flower_details, through: :order_details

  before_validation :set_default_values

  validates_presence_of :receive_address

  def init_order
    where(state: INIT)
  end

  def total_sum
    order_details.sum('amount * price')
  end

  STATES.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end

  def set_default_values
    self.note ||= ""
    self.sale_price ||= original_price
    self.state ||= INIT
  end

end
