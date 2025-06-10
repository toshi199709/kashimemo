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

  # ✅ 背景画像関連のルート
  resource :user, only: [] do
    delete :remove_background_image, on: :collection, as: :remove_background_image
  end

  patch 'users/background', to: 'users#update_background', as: :background
end
