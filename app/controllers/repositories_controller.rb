class RepositoriesController < ApplicationController
  before_filter :require_authentication

  def show
    @repository = current_user.github.repository("#{current_user.name}/#{params[:name]}")
  end
end