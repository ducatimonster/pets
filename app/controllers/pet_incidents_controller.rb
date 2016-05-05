class PetIncidentsController < ApplicationController
  before_action :set_pet_incident, only: [:show, :edit, :update, :destroy]

  # GET /pet_incidents
  # GET /pet_incidents.json
  def index
    @pet_incidents = PetIncident.all
  end

  def import
    PetIncident.import(params[:file])
    redirect_to pet_incidents_url, notice: 'Pet Incidents imported.'
  end

  # GET /pet_incidents/1
  # GET /pet_incidents/1.json
  def show
  end

  # GET /pet_incidents/new
  def new
    @pet_incident = PetIncident.new

  end

  # GET /pet_incidents/1/edit
  def edit
  end

  # POST /pet_incidents
  # POST /pet_incidents.json
  def create
    @pet_incident = PetIncident.new(pet_incident_params)

    respond_to do |format|
      if @pet_incident.save
        format.html { redirect_to @pet_incident, notice: 'Pet incident was successfully created.' }
        format.json { render :show, status: :created, location: @pet_incident }
      else
        format.html { render :new }
        format.json { render json: @pet_incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pet_incidents/1
  # PATCH/PUT /pet_incidents/1.json
  def update
    respond_to do |format|
      if @pet_incident.update(pet_incident_params)
        format.html { redirect_to @pet_incident, notice: 'Pet incident was successfully updated.' }
        format.json { render :show, status: :ok, location: @pet_incident }
      else
        format.html { render :edit }
        format.json { render json: @pet_incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pet_incidents/1
  # DELETE /pet_incidents/1.json
  def destroy
    @pet_incident.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Pet incident was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet_incident
      @pet_incident = PetIncident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_incident_params
      params.require(:pet_incident).permit(:incident_date, :pet_id, :incident_id)
    end
end
