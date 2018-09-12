Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }

  resources 'categories', only: [:index, :show]
  resources 'products', only: [:index, :show]

  get 'cart' => 'carts#index', :as => 'cart_index'
  post 'cart' => 'carts#change_quantity'
  post 'cart/add/:id' => 'carts#add', :as => 'cart_add'
  delete 'cart/remove/:id' => 'carts#delete', :as => 'cart_delete'
  delete 'cart/empty' => 'carts#empty', :as => 'empty_cart'

  resources :orders, only: [:new] do
    collection do
      post 'checkout'
      get 'execute_payment'
    end
  end

  root to: 'products#index'
end
