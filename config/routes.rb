Rails.application.routes.draw do
  get 'goals/index'
  devise_for :users
  root to: "goals#index"
  resources :goals, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :logs, only: [:index, :create, :show, :destroy]
  end
end
