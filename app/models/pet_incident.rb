class PetIncident < ActiveRecord::Base
  belongs_to :pet
  belongs_to :incident
  require 'roo'

validates :pet_id, presence: true


  # def pet_name
  #   pet.try(:pet_name)
  # end
  #
  # def pet_name=(pet_name)
  #   self.pet = Pet.find_by_pet_name(pet_name) if pet_name.present?
  # end




  def self.import(file)
    allowed_attributes = ['pet_incident']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      pet_incident = find_by_id(row["id"]) || new
      pet_incident.attributes = row.to_hash.slice(*row.to_hash.keys)
      pet_incident.save!
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
