Rails.application.routes.draw do
  root to: "requests#index"

  get   '/login', :to => 'sessions#new', :as => :login
  get   '/logout', :to => 'sessions#destroy', :as => :logout
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  post "/groups/assign", to: "groups#assign"

  post 'pusher/auth', to: 'pusher#auth'

  resources :requests do
    resources :messages
  end
end
