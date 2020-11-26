Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :users, only: [:new, :create, :show, :edit]
  namespace :admin do
    resources :users do
      collection do
        get 'change'
      end
    end
  end
  root'tasks#index'
end
