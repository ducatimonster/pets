class Breed < ActiveRecord::Base
  has_many :pet_breeds, :dependent => :delete_all
  require 'roo'

  validates_presence_of :breed
  validates_length_of :breed, :maximum => 60
  validates :breed, :format     =>  { :with => /[a-zA-Z\s]\z/}


  def self.import(file)
    allowed_attributes = ['breed']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      breed = find_by_id(row["id"]) || new
      breed.attributes = row.to_hash.slice(*row.to_hash.keys)
      breed.save!
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
