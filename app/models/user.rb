class User < ApplicationRecord
  has_one_attached :avatar
  has_many :orders
  has_one :cart, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true, length: { maximum: 50 }
  validates :address, presence: true
  validates :mobile, presence: true, length: { maximum: 13 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
end
