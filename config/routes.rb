Rails.application.routes.draw do
  devise_for :users
  root to: "goals#index"
  resources :goals, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :logs, only: [:index, :create, :show, :destroy]
  end
end
