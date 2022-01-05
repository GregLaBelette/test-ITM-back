# frozen_string_literal:true

# order model
class Order < ApplicationRecord
  validates :date, presence: true
  validates :customer_id, presence: true
  validates :country, presence: true, length: { minimum: 2 }
  validates :product_code, presence: true
  validates :product_description, presence: true, length: { minimum: 10 }
  validates :quantity, presence: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
end
