Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'
  get 'mypage', to: 'posts#mypage'


  resources :posts, except: [:show] do
    member do
      get :preview
    end
  end
end
