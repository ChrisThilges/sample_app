SampleApp::Application.routes.draw do
  get "users/new"

  root :to => 'pages#home'

  match '/signup', :to => 'users#new'

  match '/help', :to => 'pages#help'
  match '/home', :to => 'pages#home'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'

end