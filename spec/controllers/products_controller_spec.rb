require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:products) { create_list(:product, 5) }

  describe 'index' do
    it 'get list of products' do
      get :index
      expect(assigns(:products).size).to eq products.size
    end
  end

  describe 'show' do
    it 'show a product' do
      get :show, params: { id: products.first.id }
      expect(assigns(:product)).to eq products.first
      expect(response).to render_template :show
    end
  end
end
