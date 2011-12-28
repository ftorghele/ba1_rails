Ba1Rails::Application.routes.draw do

  constraints(:accept => "application/json") do
    resources :articles
  end

end
