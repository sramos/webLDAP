Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  get '/change_password' => 'home#edit_password'
  post '/change_password' => 'home#update_password'
  get '/fast_alias' => 'aliases#fast_alias'
  post '/fast_alias' => 'aliases#fast_alias_creation'
  resources :domains, constraints: { id: /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ } do
    resources :aliases
    resources :groups
    resources :people
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
