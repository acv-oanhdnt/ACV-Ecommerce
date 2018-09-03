class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include CartsHelper

  def after_sign_in_path_for(resource)
    merge_data_from_db
    super(resource)
  end
end
