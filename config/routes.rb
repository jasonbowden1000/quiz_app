Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  resources :decks, except: [:show] do
    resources :questions
  end

  get 'stats', to: 'attempts#index'
  resources :attempts, path: :quiz, only: [:create] do
    resources :problems, param: :problem_order, only: [:show, :update]
  end

  resources :quizzes, except: [:show]
end
