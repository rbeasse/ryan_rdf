Rails.application.routes.draw do
  root 'graphs#index'

  resources :graphs

  get '/graphs/:id/query', to: 'graphs#query', as: 'query'
  get '/graphs/:id/export', to: 'graphs#export', as: 'export'
  post '/graphs/:id/sparql', to: 'graphs#sparql', as: 'sparql'
end
