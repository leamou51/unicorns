Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/unicorns', to: "unicorns#index"
  get '/unicorns/:id', to: 'unicorns#show'
  get '/unicorns/:id', to: "booking#new", as: :new_booking
  get '/unicorns/new', to: 'unicorns#new', as: :new_unicorn
  post '/unicorns', to: 'unicorns#create'
end
