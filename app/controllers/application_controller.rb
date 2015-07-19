class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def categories
    @categories = Category.all if !defined?(@categories)
    @categories
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :nevernote_api_key]
    devise_parameter_sanitizer.for(:account_update) << [:username, :nevernote_api_key]
  end
end
