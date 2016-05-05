class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  # GET /pets
  # GET /pets.json

  # def multi_image_upload
  #   @pet = Pet.new()
  #   @pet.id = params[:pet_id]
  # end




  def index
    if params[:search]
      @pets = Pet.search(params[:search]).page(params[:page]).per_page(10)
    else
      @pets = Pet.all.where(:pet_status_inactive => false).order(pet_name: :asc).page(params[:page]).per_page(10)
    end
  end

  #
  # def import
  #   Pet.import(params[:file])
  #   redirect_to pets_url, notice: 'Pets imported.'
  # end

  # GET /pets/1
  # GET /pets/1.json
  def show
    @pet_breeds = PetBreed.joins(:breed).where(pet_id: @pet.id)

    @pet_incidents = PetIncident.joins(:incident).where(pet_id: @pet.id)

    @shot_records = ShotRecord.joins(:vaccination).where("pet_id = ?
                    AND shot_expiration >= ?",@pet.id, Date.today ).order("CASE vaccination_name
         WHEN 'Rabies' THEN 1
         ELSE 2 END ASC",shot_expiration: :desc)


    # @shot_records = ShotRecord.joins(:vaccination).where("pet_id =  #{@pet.id} AND shot_expiration >  #{Date.today}" ).order( shot_expiration: :desc )
    #
    # @shot_records = ShotRecord.joins(:vaccination).where("pet_id =  #{@pet.id} AND shot_expiration >  #{Date.today}" ).order("CASE vaccination_name
    #      WHEN 'Rabies' THEN 1
    #      ELSE 2 END ASC",shot_expiration: :desc)

    @groomings = Grooming.all.where(pet_id: @pet.id).order(date: :desc).limit(3)
    @notes = Note.all.where(pet_id: @pet.id).order("CASE note_importance
         WHEN 'Low' THEN 1
         WHEN 'Medium' THEN 2
         WHEN 'High' THEN 3 END DESC", created_at: :desc )

=begin
    @notes = Note.all.where(pet_id: @pet.id).order(note_importance: :desc, note_date: :desc)
=end
    @authorized_people = AuthorizedPerson.all.where(client_id: @pet.client_id)

    @images = PetImageRepo.all.where(pet_id: @pet.id).order(created_at: :desc).limit(5)
  end

  # GET /pets/new
  def new
    @pet = Pet.new()
    @pet.client_id = params[:client_id]
    1.times {@pet.pet_breeds.build}
    1.times {@pet.shot_records.build}
    1.times {@pet.notes.build}
    1.times {@pet.pet_image_repos.build}

    @authorized_people = AuthorizedPerson.all.where(client_id: @pet.client_id)

  end

  # GET /pets/1/edit
  def edit

    # 1.times {@pet.pet_breeds.build}
    # 1.times {@pet.shot_records.build}
    # 1.times {@pet.notes.build}
    # 1.times {@pet.pet_image_repos.build}
    # @authorized_people = AuthorizedPerson.all.where(client_id: @pet.client_id)
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)


    respond_to do |format|
      if @pet.save
        format.html { redirect_to new_grooming_path(:pet_id => @pet.id) }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    @pet = Pet.includes(:pet_image_repos).find(params[:id])
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: 'Pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy

    @pet = Pet.includes(:pet_image_repos).find(params[:id])
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Pet was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pet
    @pet = Pet.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pet_params
    params.require(:pet).permit(:pet_name, :pet_dob, :pet_gender, :color_id, :pet_markings, :pet_status_inactive, :pet_disclosure, :is_spay_neutered, :client_id, :profile_image,
                                pet_breeds_attributes: [:_destroy,:id,:pet_id, :breed_id],
                                shot_records_attributes: [:_destroy,:id,:pet_id, :vaccination_id, :shot_date, :shot_expiration],
                                notes_attributes: [:_destroy,:id, :note_description, :note_importance, :note_type_id],
                                colors_attributes: [:color_name],
                                pet_image_repos_attributes: [:_destroy, :id, :comment, :image])
  end


end