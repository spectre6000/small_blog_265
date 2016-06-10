Rails.application.routes.draw do
  root 'users#index'

  devise_for :users, controllers: { invitations: 'users/invitations', registrations: 'users/registrations' }
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    patch '/toggle-admin', to: 'users#toggle_admin'
  end

  resources :articles
end
