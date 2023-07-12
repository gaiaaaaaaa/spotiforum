class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if (params[:sort_by] != nil)
      case params[:sort_by]
      when "created_at"
        @posts = Post.all.order(:created_at)
      when "created_at_desc"
        @posts = Post.all.order(created_at: :desc)
      when "likes"
        @posts = Post.left_outer_joins(:likes) #con solo il join non mostra i post con 0 like
                .group('posts.id')
                .order('COUNT(likes.id) DESC')
      end
    else
      @posts = Post.all
    end
    @likes = Like.all
    @comments = Comment.all
  end

  def like
    #trovo il post attraverso l'id passato come parametro
    @post = Post.all.find(params[:id])
    #creo il like con l'id del post e l'id dell'utente attualmente loggato
    Like.create(user_id: current_user.id, post_id: @post.id)
    redirect_to posts_path #?
    #manca parte in cui ci si assicura che si possa mettere like una sola volta
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :user_id, :tag)
    end
end
