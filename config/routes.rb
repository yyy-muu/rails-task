Rails.application.routes.draw do
  root "top#index"
  
  devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
    # :omniauth_callbacks => "users/omniauth_callbacks" 
  }
  resources :users, :only => [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tweets, :only => [:new, :create]
end
