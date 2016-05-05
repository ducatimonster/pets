json.array!(@grooming_services) do |grooming_service|
  json.extract! grooming_service, :id, :service_id, :grooming_id, :notes
  json.url grooming_service_url(grooming_service, format: :json)
end
