json.array!(@notes) do |note|
  json.extract! note, :id, :note_date, :note_description, :note_importance, :note_type_id, :pet_id
  json.url note_url(note, format: :json)
end
