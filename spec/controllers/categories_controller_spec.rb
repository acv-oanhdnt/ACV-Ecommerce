require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:categories) { create_list(:category, 5) }

  describe 'index' do
    it 'get list of categories' do
      get :index
      expect(assigns(:categories).size).to eq categories.size
    end
  end

  describe 'show' do
    it 'show a category' do
      get :show, params: { id: categories.last.id }
      expect(assigns(:category)).to eq categories.last
      expect(response).to render_template :show
    end
  end
end
