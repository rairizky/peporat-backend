class AdminController < ApplicationController

    before_action :authorized_admin

    # akun petugas
    def user_index
        list_user = User.all.where(role: 'petugas').order(created_at: :desc)
        render json: {status: true, total: list_user.count, data: list_user}, status: :ok
    end

    def user_create
        @data_user = User.create(account_params)
        if @data_user.valid?
            render json: {status: true, message: 'Akun petugas berhasil dibuat!'}, status: :created
        else
            render json: {status: false, message: @data_user.errors}, status: :unprocessable_entity
        end
    end

    # laporan
    def laporan

    end

    private
    def account_params
        role = { role: 'petugas' }
        params.permit(:email, :password).merge(role)
    end
end
