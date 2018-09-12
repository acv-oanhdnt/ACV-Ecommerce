require 'rails_helper'

RSpec.configure do |config|
  config.include CartsHelper
  config.include OrdersHelper
end

RSpec.describe OrdersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:products) { create_list(:product, 3) }

  before { controller.instance_variable_set(:@current_user, user) }

  before{
    session[:cart] ||= {}
    add_item?(products.first.id, 1)
    add_item?(products.last.id, 3)
  }

  describe '#new' do
    it 'render new order page' do
      get :new
      expect(response).to render_template :new
    end

    it 'redirect when current cart is empty' do
      session[:cart] = {}
      get :new
      expect(flash[:warning]).to eq 'Your cart is empty'
      expect(response).to redirect_to cart_index_path
    end
  end

  describe '#checkout' do
    it 'create new order' do
      post :checkout, params: { order: { name: 'Test Name',
                                         phone_number: '0897654736',
                                         shipping_address: 'example address',
                                         email: 'test@test.com' } }
      _items = JSON(convert_cart_items_to_order_items(get_cart_items))
      expect(assigns(:order).data).to eq _items
      expect(assigns(:order).email).to eq 'test@test.com'
      expect(response).to redirect_to assigns(:payment).links[1].href
    end

    it 'create failed because blank params' do
      post :checkout, params: { order: { name: '',
                                         phone_number: '',
                                         shipping_address: '',
                                         email: '' } }

      expect(flash[:error]).to include("Name can't be blank")
      expect(flash[:error]).to include("Phone number can't be blank")
      expect(flash[:error]).to include("Shipping address can't be blank")
      expect(flash[:error]).to include("Email can't be blank")
      expect(response).to render_template :new
    end
  end
end
