class RemoveIncidentDateFromPetIncident < ActiveRecord::Migration
  def change
    remove_column :pet_incidents, :incident_date, :date
  end
end
