class AdministratorPassword < ApplicationRecord
    belongs_to :administrator
    validates :administrator_id, presence: true, uniqueness: true 
    validates :password, presence: true
    validates :salt, presence: true  
end
