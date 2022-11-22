class User < ApplicationRecord
    has_secure_password
    has_many :activities

    validates :username, presence: true, uniqueness: true
end
