Rails.application.routes.draw do
  devise_for :users
  get 'users/:id' => 'users#show'
  root 'users#show'
end
