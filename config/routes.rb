Rails.application.routes.draw do
  resources :users
  resources :breweries
  resources :beers

  # API ROUTES
  namespace :api do
    resources :breweries
    resources :beers
  end

end
