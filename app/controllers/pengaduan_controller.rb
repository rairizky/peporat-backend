class PengaduanController < ApplicationController

    before_action :authorized_user
    before_action :check_has_profile

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
        get_profile = User.find(@user.id).profile
        data = { status: "pending", nik: get_profile.nik }
        params.permit(:title, :tgl_pengaduan, :image, :laporan, :status).merge(data)
    end
end
