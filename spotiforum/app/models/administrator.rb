class Administrator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    before_save {self.email = email.downcase}

    validates :name, presence: true, uniqueness: true, length:{maximum:20, minimum:3}
    validates :email, presence: true, uniqueness: true, length:{maximum:50, minimum:6}, format:{with: URI::MailTo::EMAIL_REGEXP}
    validates :password, presence: true, length:{minimum:6}
    validates_confirmation_of :password
    has_many :warns
    
end
