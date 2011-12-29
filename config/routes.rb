Ba1Rails::Application.routes.draw do

  constraints(:accept => "application/json") do
    resources :articles

    root :to => 'articles#entry'
  end

end
