class FavouritesController < ApplicationController
  before_action :set_favourite, only: %i[ show edit update destroy ]

  # GET /favourites or /favourites.json
  def index
    @favourites = Favourite.all
    redirect_to posts_path
  end

  # GET /favourites/1 or /favourites/1.json
  def show
	redirect_to posts_path
  end

  # GET /favourites/new
  def new
    @favourite = Favourite.new
    redirect_to posts_path
  end

  # GET /favourites/1/edit
  def edit
	redirect_to posts_path
  end

  # POST /favourites or /favourites.json
  def create
    @favourite = Favourite.new(favourite_params)

    respond_to do |format|
      if @favourite.save
        format.html { redirect_to '/pages/community', notice: "Favourite was successfully created." }
        format.json { render :show, status: :created, location: @favourite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @favourite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favourites/1 or /favourites/1.json
  def update
    respond_to do |format|
      if @favourite.update(favourite_params)
        format.html { redirect_to '/pages/community', notice: "Favourite was successfully updated." }
        format.json { render :show, status: :ok, location: @favourite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favourite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favourites/1 or /favourites/1.json
  def destroy
    @favourite.destroy
	
    respond_to do |format|
	  redirect_path = determine_redirect_path(request.referer)
      format.html { redirect_to  redirect_path, notice: "Favourite was successfully destroyed." }
      format.json { head :no_content }
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
    def set_favourite
      @favourite = Favourite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favourite_params
      params.require(:favourite).permit(:user_id, :post_id)
    end
end
