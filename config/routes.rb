Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'
  get 'mypage', to: 'posts#mypage'

  resources :posts, except: [:show] do
    member do
      get :preview
    end

    collection do
      post :generate_lyrics   # 🎯 POST /posts/generate_lyrics にマッチするようになっている
    end
  end
end
