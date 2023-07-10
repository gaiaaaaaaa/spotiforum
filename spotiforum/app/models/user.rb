#se non autenticato con spotify, non puoi avere canzone preferita
class VincoloCanzone < ActiveModel::Validator
    def validate(record)
        if !(record.spotify == true or record.song == "")
            record.errors.add :base, "Non puoi scegliere una canzone preferita se non hai fatto login con Spotify!"
        end
    end
end

#se google = true allora spotify = false e password = ""
class VincoloGoogle < ActiveModel::Validator
    def validate(record)
        if !(record.google == false or (record.password == "" and record.spotify == false))
            record.errors.add :base, "Utente Google non può avere password o Spotify!"
        end
    end
end

#se spotify = true allora google = false e password = ""
class VincoloSpotify < ActiveModel::Validator
    def validate(record)
        if !(record.spotify == false or (record.password == "" and record.google == false))
            record.errors.add :base, "Utente Spotify non può avere password o Google!"
        end
    end
end

#sale e password non possono essere vuoti
class VincoloPassword < ActiveModel::Validator
    def validate(record)
        if ((record.password == "" and record.salt != nil) or (record.password != ""  and record.salt == nil))
            record.errors.add :base, "Sale e Password non possono essere vuoti!"
        end
    end
end

class User < ApplicationRecord
    before_save {self.email = email.downcase}

    validates :name, presence: true, uniqueness: true, length:{maximum:20, minimum:3}
    validates :email, presence: true, uniqueness: true, length:{maximum:50, minimum:6}, format:{with: URI::MailTo::EMAIL_REGEXP}
    validates_with VincoloSpotify
    validates_with VincoloGoogle
    validates_with VincoloCanzone
    validates_with VincoloPassword
    has_many :posts
    has_many :likes
    has_many :comments
    has_many :favourites
    has_one :warn
end
