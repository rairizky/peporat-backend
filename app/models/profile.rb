class Profile < ApplicationRecord

    validates :nik, presence:true, numericality: true, uniqueness: true
    validates_length_of :nik, minimum: 16
    validates :image, presence: true
    validates :nama, presence: true
    validates :telp, presence: true, numericality: true
    mount_uploader :image, ProfileUploader

    belongs_to :user
end
