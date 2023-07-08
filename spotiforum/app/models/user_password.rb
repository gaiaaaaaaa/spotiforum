class Vincolo < ActiveModel::Validator
    def validate(record)
        #TODO
        if !(record.id != utentesempliceid or utentesempliceSpotify == false)
            record.errors.add :base, "Non puoi scegliere una canzone preferita se non hai fatto login con Spotify!"
        end
    end
end

class UserPassword < ApplicationRecord
    belongs_to :user
    validates :user_id, presence: true, uniqueness: true 
    validates_with Vincolo
end
