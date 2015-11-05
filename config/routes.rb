Rails.application.routes.draw do
  root 'authors#index'
  
  devise_for :authors, controllers: { invitations: 'authors/invitations', registrations: 'authors/registrations' }
  resources :authors, only: [ :index, :show, :edit, :update, :destroy ] do
    patch '/toggle-admin', to: 'authors#toggle_admin'
  end
  
end
