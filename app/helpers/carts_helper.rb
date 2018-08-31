module CartsHelper
  def get_cart_items
    cart = session[:cart]
    product_data = {}
    if cart.present?
      # binding.pry
      products = Product.find(cart.keys)
      @total_price = 0
      products.each do |product|
        cart_item_price = cart[product.id.to_s] * product.price
        @total_price += cart_item_price
        product_data[product] = { 'quantity' => cart[product.id.to_s], 'item_price' => cart_item_price }
      end
    end
    product_data
  end

  def add_item?(product_id, quantity = 1)
    return false if quantity < 1 || Product.find_by(id: product_id).blank?
    if  session[:cart][product_id.to_s].present?
      session[:cart][product_id.to_s] += quantity
    else
      session[:cart][product_id.to_s] = quantity
    end
    true
  end

  def empty_cart
    session[:cart] = {}
  end
end
