Rails.application.routes.draw do
  devise_for :users
  root to: "suggestions#index"

  resources :suggestions, only: [:index, :new, :create, :edit, :show]# do
    # dummy
    resources :evaluations, only: [:new]
#  end

end
