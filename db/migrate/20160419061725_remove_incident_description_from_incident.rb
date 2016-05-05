class RemoveIncidentDescriptionFromIncident < ActiveRecord::Migration
  def change
    remove_column :incidents, :incident_description, :string
  end
end
