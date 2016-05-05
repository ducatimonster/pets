json.array!(@incidents) do |incident|
  json.extract! incident, :id, :incident_date, :incident_description
  json.url incident_url(incident, format: :json)
end
