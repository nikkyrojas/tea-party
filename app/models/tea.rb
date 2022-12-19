class Tea < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :customers, through: :subscriptions, dependent: :destroy
  validates_presence_of :name, :description, :temp, :brew_time
end
