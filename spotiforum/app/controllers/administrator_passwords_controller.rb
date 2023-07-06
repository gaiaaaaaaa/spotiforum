class AdministratorPasswordsController < ApplicationController
  before_action :set_administrator_password, only: %i[ show edit update destroy ]

  # GET /administrator_passwords or /administrator_passwords.json
  def index
    @administrator_passwords = AdministratorPassword.all
  end

  # GET /administrator_passwords/1 or /administrator_passwords/1.json
  def show
  end

  # GET /administrator_passwords/new
  def new
    @administrator_password = AdministratorPassword.new
  end

  # GET /administrator_passwords/1/edit
  def edit
  end

  # POST /administrator_passwords or /administrator_passwords.json
  def create
    @administrator_password = AdministratorPassword.new(administrator_password_params)

    respond_to do |format|
      if @administrator_password.save
        format.html { redirect_to administrator_password_url(@administrator_password), notice: "Administrator password was successfully created." }
        format.json { render :show, status: :created, location: @administrator_password }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @administrator_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administrator_passwords/1 or /administrator_passwords/1.json
  def update
    respond_to do |format|
      if @administrator_password.update(administrator_password_params)
        format.html { redirect_to administrator_password_url(@administrator_password), notice: "Administrator password was successfully updated." }
        format.json { render :show, status: :ok, location: @administrator_password }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @administrator_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrator_passwords/1 or /administrator_passwords/1.json
  def destroy
    @administrator_password.destroy

    respond_to do |format|
      format.html { redirect_to administrator_passwords_url, notice: "Administrator password was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator_password
      @administrator_password = AdministratorPassword.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def administrator_password_params
      params.require(:administrator_password).permit(:password, :salt)
    end
end
