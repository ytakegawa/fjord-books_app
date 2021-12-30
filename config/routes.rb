Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show', as: 'user_profile'

  resources :books
  root to: 'books#index'
end
