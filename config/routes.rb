Rails.application.routes.draw do
  resources 'products', only: [:index, :show]

  resources 'cart_items'
end
