json.array!(@pets) do |pet|
  json.extract! pet, :id, :pet_name, :pet_dob, :pet_gender, :pet_color, :pet_markings, :pet_status_inactive, :pet_disclosure, :is_spay_neutered, :client_id
  json.url pet_url(pet, format: :json)
end
