class VincoloAmministratore < ActiveModel::Validator
    def validate(record)
        if (record.user_id != record.administrator_id )
            record.errors.add :base, "L'amministratore non può ammonirsi da solo"
        end
        @user = User.all.find(record.administrator_id).first
        if !@user.admin
			record.errors.add :base, "Un utente non può ammonire un altro utente"
        end
    end
end

class Warn < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
    belongs_to :user, foreign_key: "administrator_id"
    validates :user_id, presence: true, uniqueness: true
    validates :administrator_id, presence: true
    
    
    validates_with VincoloAmministratore
    
end
