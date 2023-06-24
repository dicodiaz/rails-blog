Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users,
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
  root to: redirect('/users', status: 302)
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show]
  end
  resources :posts, only: %i[new create] do
    resources :comments, only: %i[new create index] 
  end
  resources :likes, only: %i[create destroy]
end
