class PengaduanController < ApplicationController

    before_action :authorized_user, only: [:create]
    before_action :check_has_profile, only: [:create]

    def index
        pengaduan = Pengaduan.all.order(created_at: :desc)
        render json: {status: true, total: pengaduan.count, data: pengaduan}, status: :ok
    end

    def detail_pengaduan
        detail = Pengaduan.find_by(id: params[:id])
        if detail 
            render json: {status: true, data: detail}, status: :ok 
        else
            render json: {status: false, message: "Pengaduan tidak ditemukan!" }, status: :not_found
        end
    end

    def create
        @pengaduan = Pengaduan.create(pengaduan_params)
        if @pengaduan.valid?
            render json: {status: true, message: 'Laporan berhasil dibuat!'}, status: :created
        else
            render json: {status: false, message: @pengaduan.errors}, status: :unprocessable_entity
        end
    end

    private
    def pengaduan_params
        get_profile = User.find(@user.id).profile
        data = { status: "pending", nik: get_profile.nik }
        params.permit(:title, :tgl_pengaduan, :image, :laporan, :status).merge(data)
    end
end
