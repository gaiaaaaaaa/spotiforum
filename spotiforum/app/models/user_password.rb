class Vincolo2 < ActiveModel::Validator
    def validate(record)
        @users = User.all
        @users.each do |user|
            if (record.user_id == user.id and user.spotify == false)
                record.errors.add :base, "Non puoi scegliere una password se hai già fatto login con Spotify!"
            end
        end
    end
end

class UserPassword < ApplicationRecord
    belongs_to :user
    validates_with Vincolo2
    validates :user_id, presence: true, uniqueness: true
    validates :password, presence: true
    validates :salt, presence: true
end
