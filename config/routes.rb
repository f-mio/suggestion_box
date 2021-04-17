Rails.application.routes.draw do
  devise_for :users
  root to: "suggestions#index"

  resources :suggestions, only: [:index, :new, :create, :edit, :show] do
    # dummy
#    resources :evaluations, only: [:new, :create]
#      resources :results, only: [:new, :create]
  end

  resources :user_departments_relations, only: [:index, :new, :update, :create, :destroy]
end
