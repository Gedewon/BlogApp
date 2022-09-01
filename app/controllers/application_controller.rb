class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :photo, :email, :password, :password_confirmation, :postscounter, :bio)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :photo, :email, :password, :current_password, :bio)
    end
  end
end
