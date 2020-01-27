Rails.application.routes.draw do
  resources :users
  get 'show' => 'users#show'
end
