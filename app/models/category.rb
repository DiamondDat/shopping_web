class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories
  belongs_to :parent,         class_name: Category
  has_many   :sub_categories, class_name: Category,
             foreign_key: :parent_id,
             dependent: :destroy
  validates  :name, presence: true
end
