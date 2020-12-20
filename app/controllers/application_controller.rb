class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :is_current_user_admin?

  def is_current_user_admin?
    signed_in? ? current_user.is_admin : false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :avatar, address: [:phone_number, :address_line, :street, :city, :state, :pin_code, :landmark]])
  end
end
