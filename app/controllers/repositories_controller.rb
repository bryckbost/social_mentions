class RepositoriesController < ApplicationController
  before_filter :require_authentication

  def show
    @repository = current_user.github.repository("#{params[:user]}/#{params[:name]}")
    @questions = StackExchange.search(params[:name])
    @mentions = Twitter.search(params[:name])
  end
end