class AddIncidentDescriptionToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :incident_description, :text
  end
end
