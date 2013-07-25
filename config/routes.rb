Crowdfunder::Application.routes.draw do

get '/sessions/destroy'

resources :projects do
	resources :pledges
end
 
root :to => "welcome#index"

resources :users

resources :sessions, :only => [:new, :create, :destroy]


end