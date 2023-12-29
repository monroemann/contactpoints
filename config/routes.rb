Rails.application.routes.draw do
  resources :last_known_cities
  resources :last_known_countries
  resources :locations
  resources :emotional_reactions

  resources :interaction_categories
  resources :interaction_types
  resources :interactions
  resources :categories
  resources :points
  resources :contact_types
  resources :contact_groups
  resources :contacts

  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user do
    root 'pages#home', as: :authenticated_root
  end

  post 'search', to: 'search#index', as: 'search'
  post 'search/suggestions', to: 'search#suggestions', as: 'search_suggestions'

  root to: 'pages#index'

end
