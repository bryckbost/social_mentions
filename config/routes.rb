SocialMentions::Application.routes.draw do
  get "/login" => "sessions#new"
  get "/logout" => "sessions#destroy"

  get "auth/github/callback" => "sessions#create", :success => true
  get "auth/failure" => "sessions#create", :success => false
  
  resource :account, :only => :show

  match "/:user/:name" => "repositories#show", :as => :repository
  match "/home" => "static#home"

  root :to => "static#home", :via => :get
end
