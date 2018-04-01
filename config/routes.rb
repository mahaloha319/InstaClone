Rails.application.routes.draw do
  root to: 'tops#index'
  resources :favorites, only: [:show, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :pictures
  
  resource :pictures, only: [:favorite] do
    collection do  #collection doはidなどを必要としない固有のルーティングを、member doとするとidを必要とする固有のルーティングを生成
      post :confirm
      get :favorite
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
