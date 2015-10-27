Rails.application.routes.draw do
  root 'authors#index'
  # devise_for :authors
  # devise_for :authors, controllers: { sessions: "authors/sessions" }
  devise_for :authors, controllers: { invitations: 'authors/invitations' }
  resources :authors, only: [ :index, :show, :edit, :update, :destroy ]
  
end
