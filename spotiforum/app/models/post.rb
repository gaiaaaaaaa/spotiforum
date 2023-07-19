class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :comments
    has_many :favourites
    validates :content, presence:true
    validates :user_id, presence:true
    validates :tag, presence:true
  
    validate :vincolo_tag
    
    def vincolo_tag
      unless tag.match?(/\A(?:#\w+\s)*#\w+\z/)
        errors.add(:tag, "Il formato dei tag non è valido.")
      end
	end
  
    def liked?(current_user)
		  likes.exists?(user_id: current_user.id)
	end
	
	def favourited?(current_user)
		  favourites.exists?(user_id: current_user.id)
	end
	  
	 def user_warned?
		user = User.find(user_id)
		user.warn.present?
	 end
    
end
