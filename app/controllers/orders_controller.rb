class OrdersController < ApplicationController
  include CartsHelper
  include OrdersHelper

  before_action :authenticate_user!, only: [:index, :show]
  before_action :set_order, :set_payment, only: [:execute_payment, :show]
  before_action :check_cart, only: [:new, :checkout]

  def index
    @orders = current_user.orders.paginate(page: params[:page]).order(:created_at => :asc)
  end

  def new
    @order = Order.new(user: current_user)
    @order_items = get_cart_items
  end

  def checkout
    item_list = get_cart_items
    @payment = create_request_payment(item_list, execute_payment_orders_url, root_url)
    if @payment.create
      @order = Order.new(order_params.merge(user_id: current_user.try(:id),
                                            data: JSON(convert_cart_items_to_order_items(item_list)),
                                            total_amount: @total_price,
                                            payment_id: @payment.id))
      Order.transaction do
        if @order.save
          redirect_to @payment.links[1].href
        else
          raise ActiveRecord::Rollback
          flash[:error] = @order.errors.full_messages
          render :new
        end
      end
    else
      flash[:error] = @payment.error
      redirect_to root_url
    end
  end

  def show
    @order = Order.find(params[:order_id])
    @order_items = @order.get_order_items
    @mail_status = true
    OrderMailer.finished_order_email(@order).deliver_now rescue @mail_status = false
  end

  def execute_payment
    if @payment.execute(payer_id: params[:PayerID])
      @order.pay!
      flash.now[:success] = 'Execute payment successfully'
      @items = @order.get_order_items
      empty_cart
      render 'show'
    else
      flash[:error] = 'Execute payment fail'
      redirect_to root_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone_number, :shipping_address, :email)
  end

  def set_order
    @order = Order.find_by(payment_id: params[:paymentId], user: current_user)
    redirect_to root_path, notice: 'Order payment not found' if @order.blank?
  end

  def set_payment
    @payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
  rescue StandardError
    redirect_to root_path, notice: 'Payment not found'
  end

  def check_cart
    if session[:cart].blank?
      flash[:warning] = 'Your cart is empty'
      redirect_to cart_index_path
    end
  end
end
