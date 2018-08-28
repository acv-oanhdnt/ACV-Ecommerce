class CartsController < ApplicationController
  def create
    cart = current_cart
    product = Product.find(params[:product_id].to_i)

    product_data = {
      id: product.id,
      name: product.name,
      img: product.img_url,
      price: product.price
    }

    if (cart.data.key? product.id.to_s)
      product_data['quantity'] = cart.data[product.id.to_s]["quantity"].to_i + params[:quantity].to_i
    else
      product_data['quantity'] = 1
    end

    cart.data[product.id] = product_data

    return redirect_to product_path(product.id) if cart.save
    redirect_to product_path(product.id), notice: 'Error when adding item to cart.'
  end
end
