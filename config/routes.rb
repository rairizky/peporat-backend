Rails.application.routes.draw do
  
  # auth
  post '/register', to: 'user#register'
  post '/login', to: 'user#login'
  get '/test', to: 'user#test'

  # user
  get '/profile', to: 'profile#index'

  # pengaduan
  post '/pengaduan/create', to: 'pengaduan#create'

end
