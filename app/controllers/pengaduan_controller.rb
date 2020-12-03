class PengaduanController < ApplicationController

    before_action :authorized_user

    def create
        @pengaduan = Pengaduan.create(pengaduan_params)
        if @pengaduan.valid?
            render json: {status: true, message: 'Laporan berhasil dibuat!'}, status: :created
        else
            render json: {status: false, error: @pengaduan.errors}, status: :unprocessable_entity
        end
    end

    private
    def pengaduan_params
        status = { status: "pending" }
        params.permit(:title, :tgl_pengaduan, :nik, :image, :laporan, :status).merge(status)
    end
end
