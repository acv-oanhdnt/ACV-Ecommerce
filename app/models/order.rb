class Order < ApplicationRecord
  belongs_to :user
  after_initialize :shipping_details

  def shipping_details
    return if self.user.blank?
    self.name = name || user.first_name + ' ' + user.last_name
    self.phone_number = phone_number || user.phone
    self.email = email || user.email
    self.shipping_address = shipping_address
    self.note = note
  end

  def pay!
    self.pay_stt = true
    save
  end

  def get_order_items
    data = JSON.parse(self.data)
    products = Product.find(data.keys)
    order_items = {}
    products.each do |product|
      order_items[product] = data[product.id.to_s]
    end
    order_items
  end
end
