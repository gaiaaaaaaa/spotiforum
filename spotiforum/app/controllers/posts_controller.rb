class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    base = Post
    if (params[:sort_by] != nil)
      case params[:sort_by]
      when "created_at"
        base = base.order(:created_at)
      when "created_at_desc"
        base = base.order(created_at: :desc)
      when "likes"
        base = base.left_outer_joins(:likes) #con solo il join non mostra i post con 0 like
                .group('posts.id')
                .order('COUNT(likes.id) DESC')
      when "comments"
        base = base.left_outer_joins(:comments) #con solo il join non mostra i post con 0 like
                .group('posts.id')
                .order('COUNT(comments.id) DESC')
      end
    end
    if (params[:filter_favourite] != nil)
		  base = base.joins(:favourites).where(favourites: {user_id: current_user.id})
    end
    if (params[:search_tag] != nil)
		base = base.where("tag LIKE ?", "%##{params[:search_tag]}%")
    end
    warned = Warn.pluck(:user_id)
    warned_posts = base.includes(:user).where(user_id: warned)
    not_warned_posts = base.includes(:user).where.not(user_id: warned)
    @posts = not_warned_posts + warned_posts
    @likes = Like.all
    @comments = Comment.all
  end

  def like
    if user_signed_in? and !current_user.is_admin?
		#trovo il post attraverso l'id passato come parametro
		@post = Post.all.find(params[:id])
		#creo il like con l'id del post e l'id dell'utente attualmente loggato
		Like.create(user_id: current_user.id, post_id: @post.id)
		redirect_to posts_path 
		#manca parte in cui ci si assicura che si possa mettere like una sola volta
    else
		redirect_to root_path
    end
  end

  def favourite
	if user_signed_in? and !current_user.is_admin?
		#trovo il post attraverso l'id passato come parametro
		@post = Post.all.find(params[:id])
		#creo il favourite con l'id del post e l'id dell'utente attualmente loggato
		Favourite.create(user_id: current_user.id, post_id: @post.id)
		redirect_to posts_path 
		#manca parte in cui ci si assicura che si possa mettere like una sola volta
	else
		redirect_to posts_path
	end
  end
  
  def warn
	if user_signed_in? and current_user.is_admin?
		@user = User.all.find(params[:id])
		Warn.create(user_id: @user.id, administrator_id: current_user.id)
		redirect_to posts_path 
	else
		redirect_to posts_path
	end
  end
  
  def ban
	if user_signed_in? and current_user.is_admin?
		#da definire dopo aver creato la blacklist
		@user = User.all.find(params[:id])
		email = @user.email
		@user.destroy
		Blacklist.create(email: email)
		redirect_to posts_path
	else
		redirect_to posts_path
	end
  end
  

  # GET /posts/1 or /posts/1.json
  def show
	redirect_to root_path
  end

  # GET /posts/new
  def new
    if user_signed_in? and !current_user.is_admin?
      @post = Post.new
    else
      redirect_to '/pages/community'
    end
  end

  # GET /posts/1/edit
  def edit
	if !current_user.is_admin?
		redirect_to root_path
	end
  end

  # POST /posts or /posts.json
  def create
	if user_signed_in?
		@post = Post.new(post_params)
		@post.user = current_user

		respond_to do |format|
		  if @post.save
			format.html { redirect_to '/pages/community', notice: "Post was successfully created." }
			format.json { render :show, status: :created, location: @post }
		  else
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: @post.errors, status: :unprocessable_entity }
		  end
		end
	else
		redirect_to root_path
	end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
	if user_signed_in?
		respond_to do |format|
		  if @post.update(post_params)
			format.html { redirect_to posts_path, notice: "Post was successfully updated." }
			format.json { render :show, status: :ok, location: @post }
		  else
			format.html { render :edit, status: :unprocessable_entity }
			format.json { render json: @post.errors, status: :unprocessable_entity }
		  end
		end
	else
		redirect_to root_path
	end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
	if user_signed_in? or (user_signed_in? and current_user.is_admin?)
		@post.destroy

		respond_to do |format|
		  #determino il path di destinazione in base all'indirizzo sorgente
		  redirect_path = determine_redirect_path(request.referer)
		  format.html { redirect_to redirect_path, notice: "Post was successfully destroyed." }
		  format.json { head :no_content }
		end
	else
		redirect_to root_path
	end
  end

  private
  #funzione per determinare il path
  def determine_redirect_path(referer)
    if referer.present? 
      if referer.include?('users')
        return user_path(current_user.id)
      elsif referer.include?('/pages/community') or referer.include?('posts')
        return '/pages/community'
      else
        return root_path
      end
    else
      return root_path
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :user_id, :tag)
    end
end
