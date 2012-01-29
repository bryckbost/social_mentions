SocialMentions::Application.routes.draw do
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  get "auth/github/callback" => "sessions#create", :success => true
  get "auth/failure" => "sessions#create", :success => false
  
  resources :users, :only => :show
  
  root :to => "static#home", :via => :get
end
