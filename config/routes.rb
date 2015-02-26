Rails.application.routes.draw do
  root 'sites#index'

  resources :sites, only: [:index, :show]

  resources :score_types, only: [:show]
end
