json.array!(@employees) do |employee|
  json.extract! employee, :id, :employee_first_name, :employee_last_name, :emergency_contact_number, :employee_status
  json.url employee_url(employee, format: :json)
end
