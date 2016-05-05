class PetBreed < ActiveRecord::Base
  belongs_to :pet
  belongs_to :breed
  require 'roo'


  validates :breed_id, presence: true
  def self.import(file)
    allowed_attributes = ['pet_breed']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      pet_breed = find_by_id(row["id"]) || new
      pet_breed.attributes = row.to_hash.slice(*row.to_hash.keys)
      pet_breed.save!
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
