Rails.application.routes.draw do
  root to: 'visitors#index'
  resources :users, :only => [:index, :show]

  get '/auth/:provider/callback' => 'sessions#create'

  #match 'contact' => 'inquiries#new', via: 'get'

  #match 'sigin', to: 'sessions#new', :as => :signin
  get '/signin' => 'sessions#new', :as => :signin



  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  get '/github' => 'github#index'



  match 'about', to: 'pages#about', via: 'get'
  match 'contact', to: 'pages#contact', via: 'get'
end
