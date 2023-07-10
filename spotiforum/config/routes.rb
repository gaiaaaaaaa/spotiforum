Rails.application.routes.draw do
  resources :favourites
  resources :comments
  resources :likes
  resources :posts
  resources :warns
  resources :administrator_passwords
  resources :user_passwords
  resources :administrators
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
