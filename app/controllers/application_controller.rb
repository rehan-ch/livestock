class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    def page
        params[:page].present? ? params[:page] : 1
    end

    def per(per_page = 10)
        params[:per].present? ? params[:per] : per_page
    end

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :avatar, :phone_no)}
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :avatar, :phone_no)}
        end
end
