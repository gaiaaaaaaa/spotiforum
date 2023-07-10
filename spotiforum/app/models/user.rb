class Vincolo1 < ActiveModel::Validator
    def validate(record)
        if !(record.spotify == true or record.song == "")
            record.errors.add :base, "Non puoi scegliere una canzone preferita se non hai fatto login con Spotify!"
        end
    end
end

class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates_with Vincolo1
    has_many :posts
    has_many :likes
    has_many :comments
    has_one :warn
    has_one :user_password
    has_many :comments, through: :posts
end
