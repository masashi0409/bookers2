Rails.application.routes.draw do
  get 'users/show'
  root to: 'homes#top'
  devise_for :users
  resources :books, only: [:create, :index, :show, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end
