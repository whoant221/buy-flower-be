class User < ApplicationRecord
  has_secure_password

  validates :email, format: {with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i}
  validates_presence_of :password_digest
  validates :name, :presence => true
  validates_presence_of :address
  validates_presence_of :phone_number
end
