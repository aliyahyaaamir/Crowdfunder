Crowdfunder::Application.routes.draw do

  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

resources :projects

root :to => "welcome#index"

resources :users

resources :sessions, :only => [:new, :create, :destroy]

end