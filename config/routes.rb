Rails.application.routes.draw do
  devise_for :users
  root to: "suggestions#index"

  resources :suggestions, only: [:index, :new, :create, :edit, :show] do
    # dummy
#    resources :evaluations, only: [:new, :create]
#      resources :results, only: [:new, :create]
  end

  resources :departments, only: [:index, :new, :edit]
end
