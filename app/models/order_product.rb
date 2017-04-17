class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order
  validates :order_id,    presence: true
  validates :product_id,  presence: true
  validates :quantity,    presence: true,
                          numericality: { only_integer: true, greater_than: 0 }

  def order_price
    self.pluck(:total_price).inject {:+}
  end

end
