Rails.application.routes.draw do
  root 'home#index'
  # SEARCH ROUTES
  resources :beers do
    get 'search', on: :collection
  end

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
