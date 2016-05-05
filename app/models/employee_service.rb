class EmployeeService < ActiveRecord::Base
  belongs_to :employee
  belongs_to :service
  require 'roo'

  def self.import(file)
    allowed_attributes = ['employee_service']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      employee_service = find_by_id(row["id"]) || new
      employee_service.attributes = row.to_hash.slice(*row.to_hash.keys)
      employee_service.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
