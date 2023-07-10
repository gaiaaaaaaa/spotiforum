class VincoloPreferiti < ActiveModel::Validator
    def validate(record)
        @favourites = Favourite.all
        @favourites.each do |favourite|
            if (record.id != favourite.id and record.post_id == favourite.post_id and record.user_id == favourite.user_id)
                record.errors.add :base, "Hai già messo tra i preferiti questo post!"
            end
        end
    end
end


class Favourite < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates :user_id, presence:true
    validates :post_id, presence:true
    validates_with VincoloPreferiti
end
