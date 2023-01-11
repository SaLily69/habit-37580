Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: "goals#index"
  resources :goals, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :logs, only: [:index, :create, :show, :destroy]
  end
end
