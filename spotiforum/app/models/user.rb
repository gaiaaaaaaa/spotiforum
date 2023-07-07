class Vincolo < ActiveModel::Validator
    def validate(record)
        if !(record.spotify == true or record.song == "")
            record.errors.add :base, "Non puoi scegliere una canzone preferita se non hai fatto login con Spotify!"
        end
    end
end

class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates_with Vincolo
end
