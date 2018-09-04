class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_cart
  validates_presence_of :first_name, :last_name, :phone
  has_one :cart, dependent: :destroy
  has_many :user_addresses
  has_many :orders 

  accepts_nested_attributes_for :user_addresses,
                                allow_destroy: true,
                                reject_if: lambda {|attrs| attrs['name'].blank?}

  def create_cart
    Cart.create(user: self, data: '{}')
  end
end
