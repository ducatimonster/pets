class PetImageReposController < ApplicationController
  before_action :set_pet_image_repo, only: [:show, :edit, :update, :destroy]

  # GET /pet_image_repos
  # GET /pet_image_repos.json

  def pet_image_index

    @pet_id = params[:pet_id]
    @images = PetImageRepo.pet_images(@pet_id)
  end

  def index
    @pet_image_repos = PetImageRepo.all
  end

  # GET /pet_image_repos/1
  # GET /pet_image_repos/1.json
  def show
  end

  # GET /pet_image_repos/new
  def new
    @pet_image_repo = PetImageRepo.new
    @pet_image_repo.pet_id = params[:pet_id]
  end

  # GET /pet_image_repos/1/edit
  def edit
  end

  # POST /pet_image_repos
  # POST /pet_image_repos.json
  def create
    @pet_image_repo = PetImageRepo.new(pet_image_repo_params)

    respond_to do |format|
      if @pet_image_repo.save
        format.html { redirect_to @pet_image_repo, notice: 'Image was successfully uploaded.' }
        format.json { render :show, status: :created, location: @pet_image_repo }
      else
        format.html { render :new }
        format.json { render json: @pet_image_repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pet_image_repos/1
  # PATCH/PUT /pet_image_repos/1.json
  def update
    respond_to do |format|
      if @pet_image_repo.update(pet_image_repo_params)
        format.html { redirect_to @pet_image_repo, notice: 'Image successfully updated.' }
        format.json { render :show, status: :ok, location: @pet_image_repo }
      else
        format.html { render :edit }
        format.json { render json: @pet_image_repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pet_image_repos/1
  # DELETE /pet_image_repos/1.json
  def destroy
    @pet_image_repo.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Image was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet_image_repo
      @pet_image_repo = PetImageRepo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_image_repo_params
      params.require(:pet_image_repo).permit(:pet_id, :comment, :image)
    end
end
