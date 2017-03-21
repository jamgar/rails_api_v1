Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    post '/signup', to: 'users#create'
    resources :contacts
    resources :users
  end
end
