json.array!(@employee_services) do |employee_service|
  json.extract! employee_service, :id, :employee_id, :service_id
  json.url employee_service_url(employee_service, format: :json)
end
