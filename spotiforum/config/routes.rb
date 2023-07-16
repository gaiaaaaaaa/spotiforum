Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'
  get 'pages/community' => 'posts#index'
  post '/post/:id/like', to: 'posts#like', as: 'like'
  post 'users/search', to: 'users#search'
  post 'users/user_artist', to: 'users#user_artist'
  post 'users/user_song', to: 'users#user_song'
  post 'users/create_recommended_playlist', to: 'users#create_recommended_playlist'
  post 'users/create_your_own_playlist', to: 'users#create_your_own_playlist'
  get 'profiles/home'
  devise_for :administrators, controllers: {
	  sessions: 'administrators/sessions',
	  registrations: 'administrators/registrations'
  }
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
	  sessions: 'users/sessions',
	  registrations: 'users/registrations',
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
