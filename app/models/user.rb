class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise   :database_authenticatable, :registerable, :confirmable,
           :recoverable, :rememberable, :trackable, :validatable
  has_many :carts,  dependent: :destroy
  has_many :products, through: :carts
  has_many :orders, dependent: :destroy

  validates :name,  presence: true, length: { minimum: 5, maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :encrypted_password, presence: true, length: { minimum: 6 }
end
