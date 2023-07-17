class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :comments
    has_many :favourites
    validates :content, presence:true
    validates :user_id, presence:true
    validates :tag, presence:true
    
    def liked?(current_user)
		likes.exists?(user_id: current_user.id)
	end
  
end
