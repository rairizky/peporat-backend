Rails.application.routes.draw do
  
  # auth
  post '/register', to: 'user#register'
  post '/login', to: 'user#login'
  get '/test', to: 'user#test'

  # user
  get '/profile', to: 'profile#index'
  post '/profile/create', to: 'profile#create'
  patch '/profile/update', to: 'profile#update'

  # pengaduan
  post '/pengaduan/create', to: 'pengaduan#create'

end
