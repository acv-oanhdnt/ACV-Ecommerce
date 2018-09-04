class OrdersController < ApplicationController
  include CartsHelper

  def new
    @order = Order.new(user: current_user)
    @order_items = get_cart_items
  end
end
