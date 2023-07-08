class AdministratorPassword < ApplicationRecord
    belongs_to :administrator
    validates :administrator_id, presence: true, uniqueness: true 
end
