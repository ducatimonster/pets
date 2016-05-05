class NoteTypesController < ApplicationController
  before_action :set_note_type, only: [:show, :edit, :update, :destroy]

  # GET /note_types
  # GET /note_types.json
  def index
    @note_types = NoteType.all.order(note_type: :asc).page(params[:page]).per_page(15)
  end

  def import
    NoteType.import(params[:file])
    redirect_to note_types_url, notice: 'Note Types imported.'
  end

  # GET /note_types/1
  # GET /note_types/1.json
  def show
  end

  # GET /note_types/new
  def new
    @note_type = NoteType.new
  end

  # GET /note_types/1/edit
  def edit
  end

  # POST /note_types
  # POST /note_types.json
  def create
    @note_type = NoteType.new(note_type_params)

    respond_to do |format|
      if @note_type.save
        format.html { redirect_to @note_type, notice: 'Note type was successfully created.' }
        format.json { render :show, status: :created, location: @note_type }
      else
        format.html { render :new }
        format.json { render json: @note_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_types/1
  # PATCH/PUT /note_types/1.json
  def update
    respond_to do |format|
      if @note_type.update(note_type_params)
        format.html { redirect_to @note_type, notice: 'Note type was successfully updated.' }
        format.json { render :show, status: :ok, location: @note_type }
      else
        format.html { render :edit }
        format.json { render json: @note_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_types/1
  # DELETE /note_types/1.json
  def destroy
    @note_type.destroy
    respond_to do |format|
      format.html { redirect_to note_types_url, notice: 'Note type was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note_type
      @note_type = NoteType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_type_params
      params.require(:note_type).permit(:note_type)
    end
end
