Rails.application.routes.draw do

  resources :wikis
  resources :charges
  devise_for :users, controllers: { sessions: 'users/sessions' }

  get 'welcome/index'
  root 'wikis#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
