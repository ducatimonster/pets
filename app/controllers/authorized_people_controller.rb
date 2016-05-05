class AuthorizedPeopleController < ApplicationController
  before_action :set_authorized_person, only: [:show, :edit, :update, :destroy]

  # GET /authorized_people
  # GET /authorized_people.json
  def index
    @authorized_people = AuthorizedPerson.all
  end

  def import
    AuthorizedPerson.import(params[:file])
    redirect_to authorized_people_url, notice: 'Authorized People Imported.'
  end

  # GET /authorized_people/1
  # GET /authorized_people/1.json
  def show
  end

  # GET /authorized_people/new
  def new
    @authorized_person = AuthorizedPerson.new
    @authorized_person.client_id = params[:client_id]
  end

  # GET /authorized_people/1/edit
  def edit
  end

  # POST /authorized_people
  # POST /authorized_people.json
  def create
    @authorized_person = AuthorizedPerson.new(authorized_person_params)

    respond_to do |format|
      if @authorized_person.save
        format.html { redirect_to @authorized_person, notice: 'Authorized person was successfully created.' }
        format.json { render :show, status: :created, location: @authorized_person }
      else
        format.html { render :new }
        format.json { render json: @authorized_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authorized_people/1
  # PATCH/PUT /authorized_people/1.json
  def update
    respond_to do |format|
      if @authorized_person.update(authorized_person_params)
        format.html { redirect_to @authorized_person, notice: 'Authorized person was successfully updated.' }
        format.json { render :show, status: :ok, location: @authorized_person }
      else
        format.html { render :edit }
        format.json { render json: @authorized_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authorized_people/1
  # DELETE /authorized_people/1.json
  def destroy
    @authorized_person.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Authorized person was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authorized_person
      @authorized_person = AuthorizedPerson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authorized_person_params
      params.require(:authorized_person).permit(:full_name, :authorized_person_telephone, :client_id)
    end
end
