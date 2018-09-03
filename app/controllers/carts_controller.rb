class CartsController < ApplicationController
  include CartsHelper

  before_action :set_cart, except: [:empty]
  after_action :merge_cart_to_db, except: [:index, :empty]

  def index
    @cart_items = get_cart_items
  end

  def add
    quantity = params[:quantity].try(:to_i) || 1
    if !add_item?(params[:product_id], quantity)
      flash[:warning] = 'Invalid quantity'
    end
    redirect_to products_path
  end

  def delete
    # binding.pry
    session[:cart].delete(params[:id].to_s)
    flash[:success] = 'Delete item Successfully'
    redirect_to cart_index_path
  end

  def change_quantity
    if params[:quantity].blank? || params[:quantity].to_i < 1
      flash[:warning] = 'Quantity invalid'
    else
      session[:cart][params[:product_id]] = params[:quantity].to_i
    end
    redirect_to cart_index_path
  end

  def empty
    empty_cart
    flash[:success] = 'Your Cart is Empty'
    redirect_to cart_index_path
  end

  private
    def set_cart
      session[:cart] ||= {}
    end
end
