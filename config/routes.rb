Ba1Rails::Application.routes.draw do
  resources :articles
  root :to => 'articles#entry'
end
