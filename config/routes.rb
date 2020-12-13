Rails.application.routes.draw do
  root 'home#index'
  get 'home/about'

  devise_for :users, controllers: {
    sessions: 'devise/sessions',  # ログインの持続
    registrations: 'devise/registrations' # 登録
  }
  root 'posts#index'
  resources :post, only: [:new, :create, :index, :show] do
    resources :post_comments, only: [:create, :destroy]
  end

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  resources :users
  resources :posts
end
