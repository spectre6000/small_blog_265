Rails.application.routes.draw do
  # devise_for :authors
  devise_for :authors, controllers: { sessions: "authors/sessions" }
  resources :authors, only: [ :index, :show ]
  
end
