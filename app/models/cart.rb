class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :user_id,    presence: true
  validates :product_id, presence: true
  validates :quantity,   presence: true,
                         numericality: { only_integer: true, greater_than: 0 }

  def self.create_or_update(user_id, product_id, quantity)
    cart = find_by(user_id: user_id, product_id: product_id)
    if cart
      cart.update_attributes(quantity: cart.quantity + quantity.to_i)
    else
      cart = create(user_id: user_id, product_id: product_id, quantity: quantity)
      cart.persisted?
    end
  end

  def cart_price
    self.inject { |sum, op| sum + op.product.price * quantity }
  end

end
