module DeviseWhitelist
  extend ActiveSupport::Concern

  included do
    before_action :config_permitted_params, if: :devise_controller?
  end

  def config_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, user_addresses_attributes: [:id, :name, :address, :line2, :city, :country_code, :_destroy]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, user_addresses_attributes: [:id, :name, :address, :line2, :city, :country_code, :_destroy]])
  end
end
