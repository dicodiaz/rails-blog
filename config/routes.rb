Rails.application.routes.draw do
  root to: redirect('/users', status: 302)
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show]
  end
  resources :posts, only: %i[new create]
  resources :comments, only: %i[new create]
  resources :likes, only: %i[new create]
end
