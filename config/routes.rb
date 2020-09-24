Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/help'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/attend_event/:id', to: 'users#attend_event', as: 'attend_event'
  resources :events
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
