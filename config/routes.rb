Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  resources :decks do
    resources :questions
  end

  get 'stats', to: 'attempts#index'
  resources :attempts, path: :quiz, except: [:index] do
    resources :problems, param: :problem_order
  end

  resources :quizzes, except: [:show]
end
