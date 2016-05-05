class EmployeeServicesController < ApplicationController
  before_action :set_employee_service, only: [:show, :edit, :update, :destroy]

  # GET /employee_services
  # GET /employee_services.json
  def index
    @employee_services = EmployeeService.all
  end

  def import
    EmployeeService.import(params[:file])
    redirect_to employee_services_url, notice: 'Employee Services imported.'
  end

  # GET /employee_services/1
  # GET /employee_services/1.json
  def show
  end

  # GET /employee_services/new
  def new
    @employee_service = EmployeeService.new
  end

  # GET /employee_services/1/edit
  def edit
  end

  # POST /employee_services
  # POST /employee_services.json
  def create
    @employee_service = EmployeeService.new(employee_service_params)

    respond_to do |format|
      if @employee_service.save
        format.html { redirect_to @employee_service, notice: 'Employee service was successfully created.' }
        format.json { render :show, status: :created, location: @employee_service }
      else
        format.html { render :new }
        format.json { render json: @employee_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_services/1
  # PATCH/PUT /employee_services/1.json
  def update
    respond_to do |format|
      if @employee_service.update(employee_service_params)
        format.html { redirect_to @employee_service, notice: 'Employee service was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_service }
      else
        format.html { render :edit }
        format.json { render json: @employee_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_services/1
  # DELETE /employee_services/1.json
  def destroy
    @employee_service.destroy
    respond_to do |format|
      format.html { redirect_to employee_services_url, notice: 'Employee service was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_service
      @employee_service = EmployeeService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_service_params
      params.require(:employee_service).permit(:employee_id, :service_id)
    end
end
