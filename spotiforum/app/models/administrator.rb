class Administrator < ApplicationRecord
    before_save {self.email = email.downcase}

    validates :name, presence: true, uniqueness: true, length:{maximum:20, minimum:3}
    validates :email, presence: true, uniqueness: true, length:{maximum:50, minimum:6}, format:{with: URI::MailTo::EMAIL_REGEXP}
    validates :password, presence: true
    validates :salt, presence: true
    has_many :warns
end
