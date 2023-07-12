Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'
  get 'pages/community' => 'posts#index'
  post '/post/:id/like', to: 'posts#like', as: 'like'
  devise_for :administrators, controllers: {
	sessions: 'administrators/sessions',
	registrations: 'administrators/registrations'
  }
  devise_for :users, controllers: {
	sessions: 'users/sessions',
	registrations: 'users/registrations'
  }
  resources :favourites
  resources :comments
  resources :likes
  resources :posts
  resources :warns
  resources :administrators
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
