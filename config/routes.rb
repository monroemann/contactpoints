Rails.application.routes.draw do
  get 'members/dashboard'
  
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
  resources :users, only: [:show, :edit, :update, :destroy]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user do
    root 'pages#home', as: :authenticated_root
  end

  post 'search', to: 'search#index', as: 'search'
  post 'search/suggestions', to: 'search#suggestions', as: 'search_suggestions'
  get 'all_points', to: 'pages#all_points', as: 'all_points'
  get 'all_contacts', to: 'contacts#all_contacts', as: 'all_contacts'
  get 'support', to: 'pages#support', as: 'support'
  get 'admin', to: 'admin#index', as: 'admin'

  # Stripe checkout
  get 'checkout', to: 'checkouts#show'
  get 'checkout/success', to: 'checkouts#success'
  get 'checkouts/failure', to: 'checkouts#failure'
  get 'billing', to: 'checkouts#billing'

  root to: 'pages#index'

end
