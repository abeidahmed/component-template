Rails.application.routes.draw do
  root 'component_collections#index'
  resources :categories, only: %i( show )
  resources :components, only: %i( show )
  resources :ui_resources, only: %i( index show )
end
