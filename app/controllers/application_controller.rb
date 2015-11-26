class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :check_authentication

  private
  def current_user
    @current_user ||= User.by_id(key: session[:user_id]).first if session[:user_id]
  end

  def check_authentication
    if !current_user
      head :forbidden
    end
  end
end
