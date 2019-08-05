Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  resources :decks do
    resources :questions
  end
end
