json.array!(@clients) do |client|
  json.extract! client, :id, :client_first_name, :client_last_name, :client_email, :client_telephone, :client_emergency_telephone, :client_address, :client_status, :allow_contact, :referred
  json.url client_url(client, format: :json)
end
