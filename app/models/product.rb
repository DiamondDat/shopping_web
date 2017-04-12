class Product < ApplicationRecord
  has_many :carts
  has_many :users, through:  :carts
  has_many :order_products
  has_many :orders, through: :order_products
end
