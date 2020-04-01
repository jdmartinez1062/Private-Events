Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  get 'events/index'
  get 'events/new'
  get 'events/edit'
  get 'events/create'
  get 'events/update'
  get 'events/destroy'
  get 'users/new'
  get 'users/edit'
  get 'users/create'
  get 'users/update'
  get 'users/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
