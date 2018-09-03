class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include CartsHelper

  def after_sign_up_path_for(resource)
    Cart.create(data: '{}', user_id: current_user.id) if current_user.cart.nil?
    merge_data_from_db
    super(resource)
  end

  def after_sign_in_path_for(resource)
    Cart.create(data: '{}', user_id: current_user.id) if current_user.cart.nil?
    merge_data_from_db
    super(resource)
  end
end
