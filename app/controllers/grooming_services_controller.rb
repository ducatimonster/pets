class GroomingServicesController < ApplicationController
  before_action :set_grooming_service, only: [:show, :edit, :update, :destroy]

  # GET /grooming_services
  # GET /grooming_services.json
  def index
    @grooming_services = GroomingService.all
  end

  def import
    GroomingService.import(params[:file])
    redirect_to grooming_services_url, notice: 'Grooming Services imported.'
  end

  # GET /grooming_services/1
  # GET /grooming_services/1.json
  def show
  end

  # GET /grooming_services/new
  def new
    @grooming_service = GroomingService.new
  end

  # GET /grooming_services/1/edit
  def edit
  end

  # POST /grooming_services
  # POST /grooming_services.json
  def create
    @grooming_service = GroomingService.new(grooming_service_params)

    respond_to do |format|
      if @grooming_service.save
        format.html { redirect_to @grooming_service, notice: 'Grooming service was successfully created.' }
        format.json { render :show, status: :created, location: @grooming_service }
      else
        format.html { render :new }
        format.json { render json: @grooming_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grooming_services/1
  # PATCH/PUT /grooming_services/1.json
  def update
    respond_to do |format|
      if @grooming_service.update(grooming_service_params)
        format.html { redirect_to @grooming_service, notice: 'Grooming service was successfully updated.' }
        format.json { render :show, status: :ok, location: @grooming_service }
      else
        format.html { render :edit }
        format.json { render json: @grooming_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grooming_services/1
  # DELETE /grooming_services/1.json
  def destroy
    @grooming_service.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Grooming service was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grooming_service
      @grooming_service = GroomingService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grooming_service_params
      params.require(:grooming_service).permit(:service_id, :grooming_id, :notes)
    end
end
