class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  private
  def current_user
    return @current_user if defined?(@current_user)

    token = cookies.signed[:token]
    @current_user = token && User.find_by_token(token)
    cookies.delete(:token) unless @current_user
    @current_user
  end

  def require_authentication
    unless current_user
      flash[:warning] = "Log in first!"
      redirect_to root_path
    end
  end
  
  
end
