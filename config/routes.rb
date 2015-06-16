Rails.application.routes.draw do

  root 'sites#index'

  resources :sites, only: [:index, :show]

  resources :score_types, only: [:show]

  match 'about', to: 'static_content#about', via: :get
  match 'glossary', to: 'static_content#glossary', via: :get

  get '/stats', to: redirect('/stats/summary')

  resource :stats, only: [] do
    get 'summary'
    get 'distribution'
    get 'unsustainable'
  end
end
