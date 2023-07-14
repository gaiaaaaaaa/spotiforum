#se non autenticato con spotify, non puoi avere canzone preferita
class VincoloCanzone < ActiveModel::Validator
    def validate(record)
        if !(record.spotify == true or record.song == nil)
            record.errors.add :base, "Non puoi scegliere una canzone preferita se non hai fatto login con Spotify!"
        end
    end
end

#se google = true allora spotify = false e password = ""
class VincoloGoogle < ActiveModel::Validator
    def validate(record)
        if (record.google == true)
			if (record.spotify == true)
				record.errors.add :base, "Google e Spotify insieme errore!"
			end
        end
    end
end

#se spotify = true allora google = false
class VincoloSpotify < ActiveModel::Validator
    def validate(record)
        if !(record.spotify == false or record.google == false)
            record.errors.add :base, "Utente Spotify non può avere password e Google!"
        end
    end
end

# Se Spotify = false e Google = false, allora Password != NULL
class VincoloPswrd < ActiveModel::Validator
	def validate(record)
		if (record.google == false and record.spotify == false)
			if (record.password == "")
				record.errors.add :base, "Un Utente non Spotify e non Google deve avere la password!"
			end
		end
	end
end

class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :omniauthable, omniauth_providers: %i[google_oauth2 spotify]
      before_save {self.email = email.downcase}
      
      
      def self.from_omniauthGoogle(access_token)
          data = access_token.info
          user = User.where(email: data['email']).first
  
          # Uncomment the section below if you want users to be created if they don't exist
           unless user
               user = User.create(name: data['name'],
                  email: data['email'],
                  password: Devise.friendly_token[0,20],
                  google: true,
                  spotify: false
               )
           end
          user
      end

    def password_required?
		new_record? ? false : super
	end

    validates :name, presence: true, uniqueness: true, length:{maximum:40, minimum:3}
    validates :email, presence: true, uniqueness: true, length:{maximum:50, minimum:6}, format:{with: URI::MailTo::EMAIL_REGEXP}
    validates_confirmation_of :password
    validates_with VincoloSpotify
    validates_with VincoloGoogle
    #validates_with VincoloCanzone
    validates_with VincoloPswrd
    has_many :posts
    has_many :likes
    has_many :comments
    has_many :favourites
    has_one :warn
    
    def self.from_omniauthSpotify(access_token)
        data = access_token.info
        user = User.where(email: data['email']).first
    
        # Uncomment the section below if you want users to be created if they don't exist
        unless user
            user = User.create(email: data['email'],
                name: data['name'],
                password: Devise.friendly_token[0,20],
                google: false,
                spotify: true
            )
        end
        user
    end

end
