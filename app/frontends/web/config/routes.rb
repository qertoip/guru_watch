Web::Application.routes.draw do

  root :to => 'pages#index'

  #namespace :entities do
    resources :gurus, :module => nil
  #end

end
