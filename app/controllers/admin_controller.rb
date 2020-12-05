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
        @pengaduan = Pengaduan.where(nil).order(created_at: :desc)
        status = params[:status]
        month = params[:month]
        year = params[:year]
        if status or month or year
            @pengaduan = Pengaduan.where(status: status).order(created_at: :desc) if status.present?
            b_awal = Date.parse("1/#{month}/#{year}") if month.present? && year.present?
            b_akhir = b_awal.end_of_month if month.present? && year.present?
            @pengaduan = Pengaduan.where(tgl_pengaduan: b_awal..b_akhir) if month.present? && year.present?
            @pengaduan = Pengaduan.where(status: status).where(tgl_pengaduan: b_awal..b_akhir) if status.present? && month.present? && year.present?
        end
        render json: {status: true, total: @pengaduan.count, data: @pengaduan}, status: :ok
    end

    private
    def account_params
        role = { role: 'petugas' }
        params.permit(:email, :password).merge(role)
    end
end
