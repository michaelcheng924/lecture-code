Rails.application.routes.draw do
  resources :users

  get '/login', to: 'sessions#new'
  resources :sessions, only: ['new', 'create']
  delete '/sessions', controller: 'sessions', action: 'destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
