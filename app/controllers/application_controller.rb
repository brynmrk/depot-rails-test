class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, :get_user
  # :page_not_found, :server_error
  include CurrentCart

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:password, :password_confirmation, :current_password)
      end
    end

    # def authorize
    #   unless User.find_by(id: session[:user_id])
    #     redirect_to login_url, notice: "Please log in"
    #   end
    # end

    # def set_i18n_locale_from_params
    #   if params[:locale]
    #     if I18n.available_locales.map(&:to_s).include?(params[:locale])
    #       I18n.locale = params[:locale]
    #     else
    #       flash.now[:notice] = "#{params[:locale]} translation not available"
    #       logger.error flash.now[:notice]
    #     end
    #   end
    # end
    #
    # def default_url_options
    #   { locale: I18n.locale }
    # end
end
