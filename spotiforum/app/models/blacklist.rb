class VincoloEmail < ActiveModel::Validator
    def validate(record)
        @users = User.all
        @users.each do |user|
            if (record.email == user.email)
                record.errors.add :base, "L'utente è bannato e non può registrarsi!"
            end
        end
    end
end

class Blacklist < ApplicationRecord

	validates_with VincoloEmail
    validates :email, presence:true
    
end

