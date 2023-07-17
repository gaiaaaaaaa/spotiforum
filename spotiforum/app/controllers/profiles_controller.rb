class ProfilesController < ApplicationController
    def home
		#rendo disponibili post, like e commenti alla view di profile (visitabile da altri utenti)
		@posts = Post.all.where(user_id: current_user.id)
		@likes = Like.all
		@comments = Comment.all
    end

end
