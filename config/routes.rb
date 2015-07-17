Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    member do
      post :save
    end
  end
  resources :categories
  resources :comments, only: [:create, :new]
end
