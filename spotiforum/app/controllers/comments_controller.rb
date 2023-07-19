class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
    redirect_to posts_path
  end

  # GET /comments/1 or /comments/1.json
  def show
	redirect_to posts_path
  end

  # GET /comments/new
  def new
    if user_signed_in? and !current_user.is_admin? and params[:post_id]
      @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id])
      #Assegno automaticamente il current_user come autore del post e l'id del post
    else
      redirect_to '/pages/community'
    end
  end

  # GET /comments/1/edit
  def edit
	redirect_to posts_path
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to '/pages/community', notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    if user_signed_in? or (user_signed_in? and current_user.is_admin?)
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to '/pages/community', notice: "Comment was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
