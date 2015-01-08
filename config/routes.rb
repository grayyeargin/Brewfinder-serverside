Rails.application.routes.draw do

  root 'home#index'

  # SEARCH ROUTES
  resources :beers do
    get 'search', on: :collection
  end

  # FULL CRUD ROUTES
  resources :users
  resources :breweries
  resources :beers

  # CREATE LIKE
  post "/likes" => "likes#create"

  # CREATE REVIEW
  post "/reviews" => "reviews#create"

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
