class GroomingsController < ApplicationController
  before_action :set_grooming, only: [:show, :edit, :update, :destroy]

  # GET /groomings
  # GET /groomings.json


  def pet_grooming_index

    @pet_id = params[:pet_id]
    @groomings = Grooming.pet_groomings(@pet_id).order(date: :desc, created_at: :desc)
  end

  def import
    Grooming.import(params[:file])
    redirect_to groomings_url, notice: 'Groomings imported.'
  end

  def index
    # @groomings = Grooming.all
    # @groomings = Grooming.all.where
    if params[:begindate].present? && params[:enddate].present?
      @begindate = params[:begindate]
      @enddate = params[:enddate]
      selection = params[:order].to_s

      @beginF = @begindate.to_date.strftime("%m/%d/%Y") rescue ""
      @endF  = @enddate.to_date.strftime("%m/%d/%Y") rescue ""

      if selection == 'Ascending'
        @order = 'asc'
      else
        @order = 'desc'
      end

     @groomings = Grooming.visits(@begindate, @enddate, @order).page(params[:page]).per_page(15)
    else
      @groomings = Grooming.all.where(date: Date.today).order(arrival_time: :desc)
    end

  end

  # GET /groomings/1
  # GET /groomings/1.json
  def show
  end

  # GET /groomings/new
  def new
    @grooming = Grooming.new
    @grooming.pet_id = params[:pet_id]
    @grooming.date = Date.today
    @grooming.arrival_time = Time.now.strftime("%I:%M%p")
  end

  # GET /groomings/1/edit
  def edit
  end

  # POST /groomings
  # POST /groomings.json
  def create
    @grooming = Grooming.new(grooming_params)

    respond_to do |format|
      if @grooming.save
        format.html { redirect_to @grooming, notice: 'Visit was successfully created.' }
        format.json { render :show, status: :created, location: @grooming }
      else
        format.html { render :new }
        format.json { render json: @grooming.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groomings/1
  # PATCH/PUT /groomings/1.json
  def update
    respond_to do |format|
      if @grooming.update(grooming_params)
        format.html { redirect_to @grooming, notice: 'Visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @grooming }
      else
        format.html { render :edit }
        format.json { render json: @grooming.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groomings/1
  # DELETE /groomings/1.json
  def destroy
    @grooming.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Visit was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grooming
      @grooming = Grooming.find(params[:id])
    end

    # Never trust parameters from the scary intenet, only allow the white list through.
    def grooming_params
      params.require(:grooming).permit(:date, :arrival_time, :pickup_time, :fleas_ticks, :matted_tangled, :pet_id,
                                       grooming_services_attributes: [:_destroy, :id, :service_id, :notes, :employee_id])
    end
end
