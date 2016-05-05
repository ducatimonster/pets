json.array!(@services) do |service|
  json.extract! service, :id, :service_description, :service_name
  json.url service_url(service, format: :json)
end
