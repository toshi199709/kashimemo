Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'

  resources :posts, except: [:show] do
    member do
      get :preview
    end
  end
end
