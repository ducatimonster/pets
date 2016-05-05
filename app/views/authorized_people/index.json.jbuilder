json.array!(@authorized_people) do |authorized_person|
  json.extract! authorized_person, :id, :full_name, :authorized_person_telephone, :client_id
  json.url authorized_person_url(authorized_person, format: :json)
end
