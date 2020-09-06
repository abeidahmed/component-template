Rails.application.routes.draw do
  root 'pages#home'
  resources :categories, only: %i( show )
end
