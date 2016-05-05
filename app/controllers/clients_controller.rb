class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    # @clients = Client.all
    @clients = Client.where(nil).order(client_status: :asc, client_first_name: :asc).page(params[:page]).per_page(10)

    @clients = @clients.search(params[:search]) if params[:search].present?

    # @clients = @clients.client_status(params[:client_status]) if params[:client_status].present?

  end

  def import
    Client.import(params[:file])
    redirect_to clients_url, notice: 'Clients imported.'
  end

  # GET /clients/1
  # GET /clients/1.json
  def show

    @pets = Pet.all.where(:client_id => @client.id).order(pet_status_inactive: :asc, created_at: :desc)
    @authorized_people = AuthorizedPerson.all.where(client_id: @client.id)
  end

  # GET /clients/new
  def new
    @client = Client.new
    2.times {@client.authorized_people.build}
  end

  # GET /clients/1/edit
  def edit
    @pets = Pet.all.where(:client_id => @client.id)
    1.times {@client.authorized_people.build}
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to new_pet_path(:client_id => @client.id) }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Client was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:client_first_name, :client_last_name, :client_email, :client_telephone, :client_emergency_telephone, :client_address, :client_status, :allow_contact, :referred, authorized_people_attributes: [:_destroy,:id,:full_name, :authorized_person_telephone, :client_id])
    end
end
