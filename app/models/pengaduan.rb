class Pengaduan < ApplicationRecord
    include LiberalEnum

    validates :title, presence: true
    validates :nik, presence: true, numericality: true
    validates_length_of :nik, minimum: 16
    validates :tgl_pengaduan, presence: true
    validates :user_id, presence: true, numericality: true, allow_blank: true
    validates :image, presence: true
    mount_uploader :image, PengaduanUploader
    validates :laporan, presence: true
    enum status: { pending: "pending", proses: "proses", selesai: "selesai" }
    liberal_enum :status
    validates :status, presence: true, inclusion: { in: statuses.values }

end
