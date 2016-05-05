json.array!(@groomings) do |grooming|
  json.extract! grooming, :id, :date, :arrival_time, :pickup_time, :fleas_ticks, :matted_tangled, :pet_id
  json.url grooming_url(grooming, format: :json)
end
