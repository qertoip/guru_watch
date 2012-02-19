Web::Application.routes.draw do

  root :to => 'pages#index'

  resources :gurus

end
