Rails.application.routes.draw do
  devise_for :users

  root 'conversation_items#index'
end
