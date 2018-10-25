Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/sign_up' => 'users#sign_up', as: 'sign_up'
  get '/sign_in' => 'users#sign_in', as: 'sign_in'
  post '/sign_in' => 'users#login', as: 'login' 
  get '/sign_out' => 'users#sign_out', as: 'sign_out' 
  
  resources :users

  post '/search' => 'postings#index', as: 'posting_search'
  
  resources :postings do
  	resource :trades
  end
  
end
