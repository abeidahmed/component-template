Rails.application.routes.draw do
  root 'component_collections#index'
  # resources :component_collections, only: %i( index )
  resources :categories, only: %i( show )
  resources :templates, only: %i( show )
end
