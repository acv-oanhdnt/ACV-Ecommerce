require 'rails_helper'

RSpec.configure do |config|
  config.include CartsHelper
end

RSpec.describe CartsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:products) { create_list(:product, 3) }

  before { controller.instance_variable_set(:@current_user, user) }

  before{
    session[:cart] ||= {}
    add_item?(products.first.id, 1)
    add_item?(products.last.id, 3)
  }

  describe "#index" do
    it 'get list products in cart' do
      get :index
      expect(assigns(:cart_items).length).to eq 2
    end
  end

  describe "#add" do
    it 'add to cart in products page' do
      session[:cart] = {}
      post :add, params: { id: products.first.id }
      expect(session[:cart].keys.count).to eq 1
    end

    it 'add to cart in show page' do
      session[:cart] = {}
      post :add, params: { id: products.last.id, quantity: 2 }
      expect(session[:cart].first.value).to eq 2
    end

    it 'add an invilid quantity' do
      session[:cart] = {}
      post :add, params: { id: products.second.id, quantity: -1 }
      expect(flash[:warning]).to eq 'Invalid quantity'
    end
  end

  describe '#change_quantity' do
    it 'alert warning when post negative number' do
      post :change_quantity, params: { id: products.first.id, quantity: -2 }
      expect(flash[:warning]).to eq 'Quantity invalid'
      expect(response).to redirect_to cart_index_path
    end
  end

  describe "#delete" do
    it 'empty cart' do
      delete :empty
      expect(flash[:success]).to eq 'Your Cart is Empty'
      expect(response).to redirect_to cart_index_path
    end
  end
end
