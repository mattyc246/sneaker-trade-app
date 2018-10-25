Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/sign_up' => 'users#sign_up', as: 'sign_up'
  get '/sign_in' => 'users#sign_in', as: 'sign_in'
  post '/sign_in' => 'users#login', as: 'login' 
  get '/sign_out' => 'users#sign_out', as: 'sign_out' 

  delete '/users/:id/delete' => 'users#destroy', as: 'user_delete'
  patch '/users/:id/update' => 'users#update', as: 'user_update'
  
  resources :users

  post '/postings' => 'postings#index', as: 'posting_search'
  delete '/postings/:id/delete' => 'postings#destroy', as: 'posting_delete'
  patch '/postings/:id/update' => 'postings#update', as: 'posting_update'

  resources :postings do
  	resource :trades
  end
  
end
