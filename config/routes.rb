Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'
  get 'mypage', to: 'posts#mypage'

  resources :posts, except: [:show] do
    member do
      get :preview
    end

    collection do
      post :generate_lyrics
    end

    resources :likes, only: [:create, :destroy]
  end

  # ✅ 背景画像編集（コントローラー統合）
  get 'users/background/edit', to: 'users#edit_background', as: :edit_background
  patch 'users/background', to: 'users#update_background', as: :background
end
