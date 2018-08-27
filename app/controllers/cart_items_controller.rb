class CartItemsController < ApplicationController
    def create
      cart = current_cart
      product = Product.find(params[:product_id])

      selected_item = cart.cart_items.where(product_id: product.id).first

      if selected_item
        selected_item.quantity += params[:quantity].to_i
      else
        selected_item = cart.cart_items.build(quantity: params[:quantity], price: product.price, product_id: product.id)
      end

      respond_to do |format|
        return redirect_to product_path(product.id) if selected_item.save
        redirect_to product_path(product.id), notice: 'Error when adding item to cart.'
      end
  end
end
