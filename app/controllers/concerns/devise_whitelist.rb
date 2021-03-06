module DeviseWhitelist
  extend ActiveSupport::Concern

  included do
    before_action :config_permitted_params, if: :devise_controller?
  end

  def config_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :phone])
  end
end
