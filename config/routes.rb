Rails.application.routes.draw do
  root 'pages#home'
  resources :categories, only: %i( show )
  resources :templates, only: %i( show )
end
