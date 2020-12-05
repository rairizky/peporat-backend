class PengaduanController < ApplicationController

    before_action :authorized_user, only: [:create, :history]
    before_action :check_has_profile, only: [:create, :history]
    rescue_from ActiveRecord::RecordNotFound, with: :pengaduan_detail_status_not_found

    def index
        pengaduan = Pengaduan.where(nil).order(created_at: :desc)
        if params[:status]
            pengaduan = Pengaduan.where(status: params[:status]).order(created_at: :desc) if params[:status].present?
        end
        render json: {status: true, total: pengaduan.count, data: pengaduan}, status: :ok
    end

    def detail_pengaduan
        detail = Pengaduan.find(params[:id])
        render json: {status: true, data: detail}, status: :ok 
    end

    def create
        @pengaduan = Pengaduan.create(pengaduan_params)
        if @pengaduan.valid?
            render json: {status: true, message: 'Laporan berhasil dibuat!'}, status: :created
        else
            render json: {status: false, message: @pengaduan.errors}, status: :unprocessable_entity
        end
    end

    def history
        get_user = User.find(@user.id)
        @pengaduan = Pengaduan.all.where(nik: get_user.profile.nik).order(created_at: :desc)
        render json: {status: true, total: @pengaduan.count, data: @pengaduan}, status: :ok
    end

    private
    def pengaduan_params
        get_profile = User.find(@user.id).profile
        data = { status: "pending", nik: get_profile.nik }
        params.permit(:title, :tgl_pengaduan, :image, :laporan, :status).merge(data)
    end

end
