class User < ApplicationRecord
  has_secure_password

  before_validation :set_default_values

  has_many :shopping_carts
  has_many :flowers, through: :shopping_carts

  has_many :orders

  has_many :comments
  has_many :flowers, through: :comments

  has_many :user_vouchers
  has_many :vouchers, through: :user_vouchers

  validates :email, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates_presence_of :password_digest, :address, :phone_number, :name

  scope :search, -> (email) {
    result = all
    result = result.where("email ILIKE ?", "%#{email}%") if email.present?

    result
  }

  private

  def set_default_values
    self.point ||= 0
  end

end
