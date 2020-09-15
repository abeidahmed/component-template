Rails.application.routes.draw do
  root 'component_collections#index'
  resources :page_collections, only: %i( index )
  resources :categories, only: %i( show )
  resources :templates, only: %i( show )
  resources :ui_resources, only: %i( index show )
end
