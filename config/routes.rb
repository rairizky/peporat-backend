Rails.application.routes.draw do
  
  post '/register', to: 'user#register'
  post '/login', to: 'user#login'
  get '/test', to: 'user#test'

end
