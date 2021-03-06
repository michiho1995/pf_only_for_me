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
    # get 'sign_in', to: 'users/sessions#new'
    # get 'sign_out', to: 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  get 'search/index'
  get 'search/search'
  #タグによって絞り込んだ投稿を表示するアクションへのルーティング
  resources :tags do
    get 'posts', to: 'search#tag_search'
  end

end