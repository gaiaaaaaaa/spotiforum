class WarnsController < ApplicationController
  before_action :set_warn, only: %i[ show edit update destroy ]

  # GET /warns or /warns.json
  def index
    @warns = Warn.all
  end

  # GET /warns/1 or /warns/1.json
  def show
  end

  # GET /warns/new
  def new
    @warn = Warn.new
  end

  # GET /warns/1/edit
  def edit
  end

  # POST /warns or /warns.json
  def create
    @warn = Warn.new(warn_params)

    respond_to do |format|
      if @warn.save
        format.html { redirect_to warn_url(@warn), notice: "Warn was successfully created." }
        format.json { render :show, status: :created, location: @warn }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @warn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warns/1 or /warns/1.json
  def update
    respond_to do |format|
      if @warn.update(warn_params)
        format.html { redirect_to warn_url(@warn), notice: "Warn was successfully updated." }
        format.json { render :show, status: :ok, location: @warn }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @warn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warns/1 or /warns/1.json
  def destroy
    @warn.destroy

    respond_to do |format|
      format.html { redirect_to warns_url, notice: "Warn was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warn
      @warn = Warn.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def warn_params
      params.require(:warn).permit(:user_id, :administrator_id)
    end
end
