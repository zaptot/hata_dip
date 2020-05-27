Rails.application.routes.draw do
  resources :posts
  resources :home
   devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/profile' => 'profile#show'

  get '/my_posts', controller: :posts, action: 'my_posts'
  get '/my_homes', controller: :home, action: 'my_homes'

  root 'posts#index'
end
