class PetugasController < ApplicationController

    before_action :authorized_petugas

    # status pengaduan belum di proses
    def list_pengaduan_nil
        pengaduan = Pengaduan.all.where(status: 'pending').where(user_id: nil).order(created_at: :desc)
        render json: {status: true, total: pengaduan.count, data: pengaduan}, status: :ok
    end

    def detail_pengaduan
        detail = Pengaduan.find_by(id: params[:id])
        if detail 
            render json: {status: true, data: detail}, status: :ok 
        else
            render json: {status: false, error: "Pengaduan tidak ditemukan!" }, status: :not_found
        end
    end

    def ambil_pengaduan
        detail = Pengaduan.where(id: params[:id]).where(user_id: nil).first
        if detail 
            if detail.update(status: 'proses', user_id: @user.id)
                render json: {status: true, message: 'Ambil pengaduan sukses'}, status: :ok
            else
                render json: {status: false, error: "Ambil pengaduan gagal!"}, status: :unprocessable_entity
            end
        else
            render json: {status: false, error: "Pengaduan tidak ditemukan!" }, status: :not_found
        end
    end

    # status pengaduan di proses
    def list_pengaduan_proses
        pengaduan = Pengaduan.all.where(status: 'proses').where(user_id: @user.id).order(created_at: :desc)
        render json: {status: true, total: pengaduan.count, data: pengaduan}
    end


    # status pengaduan
    def list_pengaduan_finish
        pengaduan = Pengaduan.all.where(status: 'selesai').where(user_id: @user.id).order(created_at: :desc)
        render json: {status: true, total: pengaduan.count, data: pengaduan}
    end
end
