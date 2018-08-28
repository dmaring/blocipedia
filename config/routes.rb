Rails.application.routes.draw do

  resources :wikis
  resources :charges, only: [:new, :create]
  resources :collaborations, only: [:index, :new, :create, :destroy, :show]

  devise_scope :user do
    post "/users/down_grade" => "users/registrations#down_grade"
  end
  # post 'users/down_grade', to: 'users/registrations#down_grade'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  get 'welcome/index'
  root 'wikis#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
