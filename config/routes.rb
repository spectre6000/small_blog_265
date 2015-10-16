Rails.application.routes.draw do
  root 'authors#index'
  # devise_for :authors
  devise_for :authors, controllers: { sessions: "authors/sessions" }
  resources :authors, only: [ :index, :show ]
  
end
