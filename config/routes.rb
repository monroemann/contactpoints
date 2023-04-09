Rails.application.routes.draw do
  resources :contact_types
  resources :contact_groups
  resources :contacts

  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'pages#index'

  authenticated :user do
    root 'pages#home', as: :authenticated_root
  end

end
