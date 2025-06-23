Rails.application.routes.draw do
  get 'playlists/index'
  get 'playlists/new'
  get 'playlists/create'
  get 'playlists/edit'
  get 'playlists/update'
  get 'playlists/destroy'
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

resources :playlists do
  resources :playlist_items, only: [:create, :update, :destroy]
end

# ⭐️ 追加
resources :playlist_items, only: [:create, :destroy]



  patch 'users/background', to: 'users#update_background', as: :background
end
