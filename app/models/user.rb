class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_cart
  validates_presence_of :first_name, :last_name, :phone
  has_one :cart, dependent: :destroy
  has_many :orders

  def create_cart
    Cart.create(user: self, data: '{}')
  end
end
