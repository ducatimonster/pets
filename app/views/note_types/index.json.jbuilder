json.array!(@note_types) do |note_type|
  json.extract! note_type, :id, :note_type
  json.url note_type_url(note_type, format: :json)
end
