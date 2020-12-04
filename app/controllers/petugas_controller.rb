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
            render json: {status: false, message: "Pengaduan tidak ditemukan!" }, status: :not_found
        end
    end

    def ambil_pengaduan
        detail = Pengaduan.where(id: params[:id]).where(status: 'pending').where(user_id: nil).first
        if detail 
            if detail.update(status: 'proses', user_id: @user.id)
                render json: {status: true, message: 'Ambil pengaduan sukses'}, status: :ok
            else
                render json: {status: false, message: "Ambil pengaduan gagal!"}, status: :unprocessable_entity
            end
        else
            render json: {status: false, message: "Pengaduan tidak ditemukan!" }, status: :not_found
        end
    end

    def selesai_pengaduan
        pengaduan = Pengaduan.where(id: params[:id]).where(status: 'proses').where(user_id: @user.id).first
        if pengaduan
            if pengaduan.tanggapan == nil
                @tanggapan = pengaduan.create_tanggapan(tanggapan_params)
                if @tanggapan.valid?
                    pengaduan.update(status: 'selesai')
                    render json: {status: true, message: 'Tanggapan berhasil ditambahkan!'}, status: :created
                else
                    render json: {status: false, message: @tanggapan.errors}, status: :unprocessable_entity
                end
            else
                render json: {status: false, message: 'Tanggapan sudah ada'}, status: :conflict
            end
        else
            render json: {status: false, message: "Pengaduan tidak ditemukan!" }, status: :not_found
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

    private
    def tanggapan_params
        data = { user_id: @user.id }
        params.permit(:tgl_tanggapan, :pesan).merge(data)
    end
end
