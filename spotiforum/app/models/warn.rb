class Warn < ApplicationRecord
    belongs_to :user
    belongs_to :administrator
    validates :user_id, presence: true, uniqueness: true
end
