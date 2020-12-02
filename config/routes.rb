Rails.application.routes.draw do
  
  get 'user/register'
  get 'user/login'
  post '/register', to: 'user#register'
  post '/login', to: 'user#login'
  get '/test', to: 'user#test'

end
