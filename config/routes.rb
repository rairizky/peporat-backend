Rails.application.routes.draw do
  
  # auth
  scope 'auth' do
    post '/register', to: 'user#register'
    post '/login', to: 'user#login'
  end
  get '/test', to: 'user#test'

  # user
  scope 'profile' do
    get '/', to: 'profile#index'
    post '/create', to: 'profile#create'
    patch '/update', to: 'profile#update'
  end

  # pengaduan
  scope 'pengaduan' do
    get '/', to: 'pengaduan#index'
    get '/:id', to: 'pengaduan#detail_pengaduan'
    post '/create', to: 'pengaduan#create'
  end

  # petugas
  scope 'petugas' do
    # pengaduan
    scope '/pengaduan' do
      # nil
      get '/', to: 'petugas#list_pengaduan_nil'
      get '/:id/detail', to: 'petugas#detail_pengaduan'
      patch '/:id/take', to: 'petugas#ambil_pengaduan'
      post '/:id/finish', to: 'petugas#selesai_pengaduan'

      # proses
      get '/proses', to: 'petugas#list_pengaduan_proses'

      # finish
      get '/finish', to: 'petugas#list_pengaduan_finish'
    end
  end

  # admin
  scope 'admin' do
    # list petugas
    scope '/user' do
      get '/', to: 'admin#user_index'
      post '/create', to: 'admin#user_create'
    end
    
    # laporan
    scope '/report' do
      get '/', to: 'admin#laporan'
    end
  end
end
