class ProfilesController < ApplicationController
    def home
		@posts = Post.all.where(user_id: current_user.id)
    end

end
