class PetNamesController < ApplicationController
  def index
    @clients = Client.select('client_first_name').order(:client_first_name).where("client_first_name like ?", "%#{params[:term]}%")
    render json: @clients.map(&:client_first_name)
  end
end
