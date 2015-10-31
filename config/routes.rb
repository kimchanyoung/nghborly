Rails.application.routes.draw do
  root to: "requests#index"

  get   '/login', :to => 'sessions#new', :as => :login
  get   '/logout', :to => 'sessions#destroy', :as => :logout
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  get  "/groups/assign", to: "groups#inquire"
  post "/groups/assign", to: "groups#assign"

  post 'pusher/auth', to: 'pusher#auth'

  get '/active', :to => 'events#active', :as => :active
  get '/river', :to => 'events#river', :as => :river
  get '/history', :to => 'events#history', :as => :history

  resources :requests do
    resources :messages
  end
end
