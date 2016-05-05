class ClientPetsController < ApplicationController
  before_action :set_client_pet, only: [:show, :edit, :update, :destroy]

  # GET /client_pets
  # GET /client_pets.json
  def index
    @client_pets = ClientPet.all
  end

  def import
    ClientPet.import(params[:file])
    redirect_to client_pets_url, notice: 'Client Pets imported.'
  end

  # GET /client_pets/1
  # GET /client_pets/1.json
  def show
  end

  # GET /client_pets/new
  def new
    @client_pet = ClientPet.new
  end

  # GET /client_pets/1/edit
  def edit
  end

  # POST /client_pets
  # POST /client_pets.json
  def create
    @client_pet = ClientPet.new(client_pet_params)

    respond_to do |format|
      if @client_pet.save
        format.html { redirect_to @client_pet, notice: 'Client pet was successfully created.' }
        format.json { render :show, status: :created, location: @client_pet }
      else
        format.html { render :new }
        format.json { render json: @client_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_pets/1
  # PATCH/PUT /client_pets/1.json
  def update
    respond_to do |format|
      if @client_pet.update(client_pet_params)
        format.html { redirect_to @client_pet, notice: 'Client pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_pet }
      else
        format.html { render :edit }
        format.json { render json: @client_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_pets/1
  # DELETE /client_pets/1.json
  def destroy
    @client_pet.destroy
    respond_to do |format|
      format.html { redirect_to client_pets_url, notice: 'Client pet was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_pet
      @client_pet = ClientPet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_pet_params
      params.require(:client_pet).permit(:client_id, :pet_id)
    end
end
