Rails.application.routes.draw do
  root to: redirect('/users', status: 302)
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show]
  end
end
