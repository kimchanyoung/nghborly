Rails.application.routes.draw do
  root to: 'welcome#index'
  
  resources :users, only: [:show]
  
  get   '/login', :to => 'sessions#new', :as => :login
  get   '/logout', :to => 'sessions#destroy', :as => :logout

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  get  "/groups/assign", to: "groups#inquire"
  get  "/groups/reassign", to: "groups#reassign"
  post "/groups/assign", to: "groups#assign"

  post 'pusher/auth', to: 'pusher#auth'
  post 'pusher/groupauth', to: 'pusher#groupauth'

  get '/active', :to => 'requests#active', :as => :active
  get '/river', :to => 'transactions#river', :as => :river
  get '/history', :to => 'transactions#history', :as => :history

  resources :users, only: [:show]

  resources :requests do
    resources :messages
    resources :votes, only: [:create]
  end

end
