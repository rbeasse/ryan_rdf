Rails.application.routes.draw do
  root 'graphs#index'

  resources :graphs

  get '/graphs/:id/browse', to: 'graphs#browse', as: 'browse'
  get '/graphs/:id/browse/:term', to: 'graphs#browse', as: 'browse_term'

  get '/graphs/:id/query', to: 'graphs#query', as: 'query'
  get '/graphs/:id/export', to: 'graphs#export', as: 'export'
  post '/graphs/:id/sparql', to: 'graphs#sparql', as: 'sparql'
end
