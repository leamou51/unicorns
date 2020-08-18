Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  
  get '/unicorns', to: "unicorns#index"
  get '/unicorns/new', to: 'unicorns#new', as: :new_unicorn
  post '/unicorns', to: 'unicorns#create'
  get '/unicorns/:id', to: 'unicorns#show', as: :unicorn_show
  get '/unicorns/:id', to: "booking#new", as: :new_booking

end
