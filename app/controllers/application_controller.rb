# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale, :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code, :adress, :self_introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal_code, :adress, :self_introduction])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
