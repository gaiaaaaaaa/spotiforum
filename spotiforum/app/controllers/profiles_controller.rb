class ProfilesController < ApplicationController
    def home
		#rendo disponibili post, like e commenti alla view di profile (visitabile da altri utenti)
		@posts = Post.all.where(user_id: params[:id])
		@likes = Like.all
		@comments = Comment.all
		if params[:id]!=nil
			@user = User.find(params[:id])
		else
			@user = current_user
		end
    end

end
