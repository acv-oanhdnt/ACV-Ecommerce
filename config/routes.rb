Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }
  resources 'products', only: [:index, :show]
  resources 'carts'
  root to: 'products#index'
end
