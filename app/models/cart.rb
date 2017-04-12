class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id,    presence: true
  validates :product_id, presence: true
  validates :quantity,   presence: true,
                         numericality: ( only_integer: true, greater_than: 0 )
end
