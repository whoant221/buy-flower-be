class UserVoucher < ApplicationRecord
  belongs_to :user
  belongs_to :voucher, :counter_cache => :orders_count

  before_validation :set_default_values

  STATES = [
    PENDING = 'pending',
    SUCCESSFUL = 'successful',
  ].freeze

  STATES.each do |state|
    define_method "mark_as_#{state}" do
      update!(state: state)
    end
    define_method "#{state}?" do
      self.state == state
    end
  end

  private

  def set_default_values
    self.state ||= PENDING
  end

end
