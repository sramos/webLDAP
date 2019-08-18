Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  get '/change_password' => 'home#edit_password'
  post '/change_password' => 'home#update_password'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
