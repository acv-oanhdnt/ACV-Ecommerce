Rails.application.routes.draw do
  devise_for :users
  resources 'products', only: [:index, :show]

  resources 'cart_items'
  root to: 'products#index'
end
