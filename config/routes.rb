Crowdfunder::Application.routes.draw do

get '/sessions/destroy'

resources :projects do
	resources :pledges, only: [:new, :create]
end
 
root :to => "welcome#index"

resources :users

resources :sessions, :only => [:new, :create, :destroy]


end