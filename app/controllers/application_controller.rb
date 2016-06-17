# Default generated application controller w/ devise additions
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    sign_up_params
    sign_in_params
  end

  def sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :email
  end

  def sign_in_params
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:username, :password, :remember_me)
    end
  end
end
