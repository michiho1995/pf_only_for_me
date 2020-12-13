Rails.application.routes.draw do
  root 'home#index'
  get 'home/about'

  devise_for :users, controllers: {
    sessions: 'devise/sessions',  # ログインの持続
    registrations: 'devise/registrations' # 登録
  }
  resources :posts do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    resource :bookmark, only: [:create, :destroy]
  end

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  
end
