class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :corporate_no, :first_name, :family_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs )
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs )
  end
end
