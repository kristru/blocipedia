Rails.application.routes.draw do
  resources :wikis
  resources :users

  devise_for :users, controllers: {
       confirmations: 'confirmations',
       sessions: 'users/sessions'
     }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
end
