json.array!(@pet_breeds) do |pet_breed|
  json.extract! pet_breed, :id, :pet_id, :breed_id, :notes
  json.url pet_breed_url(pet_breed, format: :json)
end
