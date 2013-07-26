Crowdfunder::Application.routes.draw do

get '/sessions/destroy'

resources :projects do
	resources :pledges, only: [:new, :create]
end
 
root :to => "welcome#index"

resources :users

namespace :my do
	resources :projects
end

resources :sessions, :only => [:new, :create, :destroy]


end