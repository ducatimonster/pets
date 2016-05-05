json.array!(@shot_records) do |shot_record|
  json.extract! shot_record, :id, :vaccination_id, :shot_date, :shot_expiration, :pet_id
  json.url shot_record_url(shot_record, format: :json)
end
