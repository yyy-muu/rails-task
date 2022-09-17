Rails.application.routes.draw do
  root "top#index"
  
  devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  resources :users, only: [:index, :show]

  resources :tweets, only: [:index, :new, :create, :show] do
    resources :comments, only: [:new, :create]
  end

  post 'comments/:id/like', to: 'comments#like_comment', as: 'like_comment'
  post 'tweets/:id/like', to: 'tweets#like_tweet', as: 'like_tweet'
end
