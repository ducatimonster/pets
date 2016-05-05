json.array!(@client_pets) do |client_pet|
  json.extract! client_pet, :id, :client_id, :pet_id
  json.url client_pet_url(client_pet, format: :json)
end
