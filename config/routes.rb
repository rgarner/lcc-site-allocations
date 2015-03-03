Rails.application.routes.draw do
  root 'sites#index'

  resources :sites, only: [:index, :show]

  resources :score_types, only: [:show]

  match 'about', to: 'static_content#about', via: :get
end
