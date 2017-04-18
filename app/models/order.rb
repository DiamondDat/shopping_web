class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_products, dependent: :destroy
  has_many   :products, through: :order_products
  validates :user_id, presence: true
  validates :status,  presence: true

  def order_price
    op = OrderProduct.where(order_id: id)
    op.pluck(:total_price).inject(:+)
  end

end
