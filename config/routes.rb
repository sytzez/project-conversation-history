Rails.application.routes.draw do
  resources :comments
  devise_for :users

  root 'conversation_items#index'
end
