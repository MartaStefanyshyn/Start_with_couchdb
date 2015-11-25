class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :check_authentication

  private
  def current_user
    @current_user ||= User.by_id(key: session[:user_id]).first if session[:user_id]
  end

  def check_authentication
    if !current_user
      flash[:danger] = "Please log in"
      redirect_to root_path
    end
  end
end
