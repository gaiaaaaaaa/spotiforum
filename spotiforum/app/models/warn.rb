class Warn < ApplicationRecord
    belongs_to :user
    belongs_to :administrator
    validates :user_id, presence: true, uniqueness: true
    validates :administrator_id, presence: true
end
