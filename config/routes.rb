Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'sparql', to: 'sparql#index'
  post 'sparql', to: 'sparql#sparql'
end
