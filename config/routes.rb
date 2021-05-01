Rails.application.routes.draw do
  devise_for :users
  root to: "suggestions#index"

  resources :suggestions do
#    resources :evaluations, only: [:new, :create]
#      resources :results, only: [:new, :create]
  end

  resources :user_departments_relations, only: [:index, :new, :update, :create, :destroy]
end
