Rails.application.routes.draw do
  devise_for :users, 　controllers: { registrations: 'users/registrations' }
  resources :users, only: [:index, :show]
  #get 'users/:id', to: 'users#show'
  # get 'users/new', to: 'users#new'
  # get 'users/index', to: 'users#index'
  resources :books

  root to: 'books#index'
  #devise_for :users, controllers: { registrations: 'users/registrations' }
end
