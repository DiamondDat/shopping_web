class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_products
  has_many   :products, through: :order_products
  validates :user_id, presence: true
  validates :status,  presence: true
end
