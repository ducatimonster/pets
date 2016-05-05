class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.where(nil)
    @notes = @notes.search(params[:search]) if params[:search].present?
    @notes = @notes.note_importance(params[:note_importance]) if params[:note_importance].present?

    # if params[:search]
    #   @notes = Note.search(params[:search, :note_importance]).all
    # else
    #   @notes = Note.all
    # end
  end

  def import
    Note.import(params[:file])
    redirect_to notes_url, notice: 'Notes imported.'
  end

  # GET /notes/1
  # GET /notes/1.json
  def show

  end

  # GET /notes/new
  def new
    @note = Note.new
    @note.pet_id = params[:pet_id]
end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to pets_show_path(:id => @note.pet_id), notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to pet_url(@note.pet_id), notice: 'Note was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit( :note_description, :note_importance, :note_type_id, :pet_id)
    end
end
