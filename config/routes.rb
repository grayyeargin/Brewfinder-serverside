Rails.application.routes.draw do
  root 'home#index'

  resources :users
  resources :breweries
  resources :beers

  # API ROUTES
  namespace :api do
    resources :breweries
    resources :beers
  end

  # SESSIONS ROUTES
  get "/login" => "users#login", as: "login"
  post "/sessions" => "sessions#login"
  delete "/sessions" => "sessions#logout", as: "logout"

end
