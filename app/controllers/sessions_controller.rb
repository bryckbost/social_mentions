class SessionsController < ApplicationController
  respond_to :html

  def new
    redirect_to "/auth/github"
  end

  def create
    if params[:success]
      user = User.from_omniauth!(request.env["omniauth.auth"])
      cookies.permanent.signed[:token] = user.token
      redirect_to root_path
    else
      flash[:error] = "You could not be logged in!"
      redirect_to root_path
    end
  end

  def destroy
    cookies.delete(:token)
    redirect_to root_path
  end

end
