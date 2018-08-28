class Cart < ApplicationRecord
  def total_price
    sum = 0
    self.data.each do |key, val|
      sum += val['price'].to_i * val['quantity']
    end
    sum
  end
end
