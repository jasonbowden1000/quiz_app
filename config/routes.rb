Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  resources :decks do
    resources :questions
  end

  resources :attempts, path: :quiz do
    resources :problems
  end

  resources :quizzes, except: [:show]
end
