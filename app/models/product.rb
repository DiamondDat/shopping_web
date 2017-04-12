class Product < ApplicationRecord
  has_many :carts
  has_many :users, through:  :carts
  has_many :order_products
  has_many :orders, through: :order_products

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :name,        presence: true, length: { minimum: 10, maximum: 255 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price,       presence: true


  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
