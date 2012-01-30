class StaticController < ApplicationController
  def home
    if current_user
      redirect_to account_path
    else
      render
    end
  end
end