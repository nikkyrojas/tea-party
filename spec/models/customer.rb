class Customer < ApplicationRecord
  validates_presence_of :email, :name, :password, :address
  validates_uniqueness_of :email

  # has_many :subscriptions
  has_secure_password 
  
end
