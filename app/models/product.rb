class Product < ApplicationRecord
  has_many :carts
  has_many :users,      through:  :carts
  has_many :order_products
  has_many :orders,     through: :order_products
  has_many :product_categories
  has_many :categories, through: :product_categories
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :name,        presence: true, length: { minimum: 10, maximum: 255 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price,       presence: true
  validate  :image_size

  private
  def image_size
    if image.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
