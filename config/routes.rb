Crowdfunder::Application.routes.draw do


  get "welcome/index"

resources :projects

get '/' => "welcome#index"

end