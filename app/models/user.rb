class User < ApplicationRecord
  has_secure_password

  validates_format_of  :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, :message => "Email is invalid"
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :phone_number
end
