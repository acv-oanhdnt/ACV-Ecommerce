module CartsHelper
  def get_cart_items
    cart = session[:cart]
    product_data = {}
    if cart.present?
      products = Product.where(id: cart.keys)
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
    merge_cart_to_db
  end

  # When User Login and Logout
  def merge_data_from_db
    session[:cart] ||= {}
    data = JSON.parse(current_user.cart.data)
    session[:cart].merge!(data) { |key, oldval, newval| oldval + newval }
    current_user.cart.data = JSON(session[:cart])
    current_user.cart.save!
  end

  def merge_cart_to_db
    if user_signed_in?
      if session[:cart]
        current_user.cart.data = JSON(session[:cart])
      end
      current_user.cart.save!
    end
  end
end
