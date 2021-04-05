Rails.application.routes.draw do
  devise_for :users
  root to: "suggestions#index"

  resources :suggestions, only: [:index, :new, :create, :edit, :show]

end
