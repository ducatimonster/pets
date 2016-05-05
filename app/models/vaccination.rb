class Vaccination < ActiveRecord::Base
  has_many :shot_records
  require 'roo'


  validates :vaccination_name, presence: true
  validates_length_of :vaccination_name, :maximum => 35
  validates :vaccination_name, :format     => { :with => /[a-zA-Z\s]\z/}

  def self.import(file)
    allowed_attributes = ['vaccination']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      vaccination = find_by_id(row["id"]) || new
      vaccination.attributes = row.to_hash.slice(*row.to_hash.keys)
      vaccination.save!
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
