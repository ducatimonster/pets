class ShotRecordsController < ApplicationController
  before_action :set_shot_record, only: [:show, :edit, :update, :destroy]

  # GET /shot_records
  # GET /shot_records.json

  def pet_shot_record_index
    @pet_id = params[:pet_id]

    @shot_records = ShotRecord.pet_shot_records(@pet_id)
  end

  def import
    ShotRecord.import(params[:file])
    redirect_to shot_records_url, notice: 'Shot Records imported.'
  end

  def index
    @shot_records = ShotRecord.all.order(shot_expiration: :desc)
  end

  # GET /shot_records/1
  # GET /shot_records/1.json
  def show

  end

  # GET /shot_records/new
  def new
    @shot_record = ShotRecord.new
    @shot_record.pet_id = params[:pet_id]
  end

  # GET /shot_records/1/edit
  def edit
  end

  # POST /shot_records
  # POST /shot_records.json
  def create
    @shot_record = ShotRecord.new(shot_record_params)

    respond_to do |format|
      if @shot_record.save
        format.html { redirect_to @shot_record, notice: 'Shot record was successfully created.' }
        format.json { render :show, status: :created, location: @shot_record }
      else
        format.html { render :new }
        format.json { render json: @shot_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shot_records/1
  # PATCH/PUT /shot_records/1.json
  def update

    respond_to do |format|

      if @shot_record.update(shot_record_params)

        format.html { redirect_to pets_show_path(:id => @shot_record.pet_id), notice: 'Shot record was successfully updated.' }
        format.json { render :show, status: :ok, location: @shot_record }
      else
        format.html { render :edit }
        format.json { render json: @shot_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shot_records/1
  # DELETE /shot_records/1.json
  def destroy
    @shot_record.destroy
    respond_to do |format|
      format.html { redirect_to shot_records_url, notice: 'Shot record was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shot_record
      @shot_record = ShotRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shot_record_params
      params.require(:shot_record).permit(:vaccination_id, :shot_date, :shot_expiration, :pet_id)
    end
end
