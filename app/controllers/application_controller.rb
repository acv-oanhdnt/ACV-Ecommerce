class ApplicationController < ActionController::Base
  include DeviseWhitelist

  before_action :current_cart

  def current_cart
    begin
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    @cart
  end
end
