Rails.application.routes.draw do
  get 'goals/index'
  devise_for :users
  root to: "goals#index"
  resources :goals, only:[:index, :create]
end
