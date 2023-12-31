Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "home#index"
   get 'my_portfolio', to: 'users#my_portfolio'
   get 'search_stock', to: 'stocks#search'
end
