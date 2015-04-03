Rails.application.routes.draw do

  root 'sites#index'

  resources :sites, only: [:index, :show]

  resources :score_types, only: [:show]

  match 'about', to: 'static_content#about', via: :get

  get '/stats', to: redirect('/stats/summary')

  resource :stats, only: [] do
    get 'summary'
    get 'distribution'
  end
end
