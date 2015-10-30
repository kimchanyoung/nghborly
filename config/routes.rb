Rails.application.routes.draw do
  resources :requests

  get   '/login', :to => 'sessions#new', :as => :login
  get   '/logout', :to => 'sessions#destroy', :as => :logout
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  post "/groups/assign", to: "groups#assign"

  get '/chatpage', to: 'chats#new'
  post '/chats/auth', to: 'chats#auth'
  post '/chats/post', to: 'chats#create'
end
