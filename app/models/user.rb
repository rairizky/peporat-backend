class User < ApplicationRecord
    include LiberalEnum

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true,  presence: true
    validates_length_of :password, minimum: 6
    enum role: { admin: "admin", petugas: "petugas", user: "user" }
    liberal_enum :role
    validates :role, presence: true, :inclusion => { in: roles.values }

    has_secure_password
end
