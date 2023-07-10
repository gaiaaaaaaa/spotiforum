class Vincolo3 < ActiveModel::Validator
    def validate(record)
        @likes = Like.all
        @likes.each do |like|
            if (record.id != like.id and record.post_id == like.post_id and record.user_id == like.user_id)
                record.errors.add :base, "Hai già messo like a questo post!"
            end
        end
    end
end

class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates_with Vincolo3
    validates :user_id, presence:true
    validates :post_id, presence:true
end
