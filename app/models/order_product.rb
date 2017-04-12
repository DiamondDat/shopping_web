class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :oder_id,    presence: true
  validates :product_id, presence: true
  validates :quantity,   presence: true,
                         numericality: ( only_integer: true, greater_than: 0 )
  validates :total_price
end
