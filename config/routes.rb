Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    post '/signup', to: 'users#create'
    resources :contacts
    resources :users, only: [:show, :create, :update, :destroy]
  end
end
