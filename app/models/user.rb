class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates_presence_of :password_digest, :address, :phone_number, :name
end
