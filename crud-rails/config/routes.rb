Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/members/:id' => 'member#show'
  post '/members' => 'member#create'
  patch '/members/:id' => 'member#update'
  delete '/members/:id' => 'member#delete'
end
