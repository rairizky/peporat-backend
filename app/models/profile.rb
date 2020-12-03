class Profile < ApplicationRecord
    mount_uploader :image, ProfileUploader

    belongs_to :user
end
