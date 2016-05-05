json.array!(@pet_incidents) do |pet_incident|
  json.extract! pet_incident, :id, :incident_date, :pet_id, :incident_id
  json.url pet_incident_url(pet_incident, format: :json)
end
