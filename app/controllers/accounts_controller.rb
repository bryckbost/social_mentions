class AccountsController < ApplicationController
  before_filter :require_authentication

  def show
    @user = current_user
  end
end