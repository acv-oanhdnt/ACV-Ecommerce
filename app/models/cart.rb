class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def total_price
    cart_items.map(&:total_price).sum
  end
end
