Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/sign_up' => 'users#sign_up', as: 'sign_up'
  get '/sign_in' => 'users#sign_in', as: 'sign_in'
  
  resources :users

  resources :postings do
  	resource :trades
  end
  
end
