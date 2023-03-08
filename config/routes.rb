Rails.application.routes.draw do
  devise_for :users

  resources :status_updates, only: [:new, :create]

  resources :comments, only: [:new, :create]

  root 'conversation_items#index'
end
