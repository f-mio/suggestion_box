Rails.application.routes.draw do
  devise_for :users
  root to: "suggestions#index"

  resources :suggestions do
    resources :evaluations, only: [:new, :create, :edit, :update, :destroy] do
      resources :results, only: [:new, :create, :edit, :update, :destroy]
    end

    collection do
      get 'search'
    end
  end

  resources :evaluations, only: :index
  resources :results, only: :index

  resources :user_departments_relations, only: [:index, :new, :update, :create, :destroy]

end