Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    post '/signup', to: 'users#create'
    post '/signin', to: 'sessions#create'
    delete '/signout', to: 'sessions#destroy'
    resources :contacts
    resources :users, only: [:index, :show, :create, :update, :destroy]
    resources :posts
  end
end
