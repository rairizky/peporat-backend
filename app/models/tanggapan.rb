class Tanggapan < ApplicationRecord
    
    validates :tgl_tanggapan, presence: true
    validates :pesan, presence: true
    validates :user_id, presence: true, numericality: true

    belongs_to :pengaduan
end
