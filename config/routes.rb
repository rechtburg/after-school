Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'index#index'
  resources :posts
  post "posts/comment" => "posts#comment"

  get     'signup',  to: 'users#new'
  post    'signup',  to: 'users#create'
  get     'login',   to: 'sessions#new'
  post    'login',   to: 'sessions#create'
  delete  'logout',  to: 'sessions#destroy'

  get     'mypage',  to: 'users#show'
  patch   'update',  to: 'users#update'
end
