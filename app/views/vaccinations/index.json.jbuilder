json.array!(@vaccinations) do |vaccination|
  json.extract! vaccination, :id, :vaccination_name
  json.url vaccination_url(vaccination, format: :json)
end
