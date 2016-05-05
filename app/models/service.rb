class Service < ActiveRecord::Base
  has_many :grooming_services
  require 'roo'

  validates :service_description, length: { maximum: 255 }, presence: true
  validates :service_name, presence: true

  #length
  validates_length_of :service_name, :maximum => 50
  validates :service_name, :format     => { :with => /[a-zA-Z\s]\z/}

  validates :service_description, :format     => { :with => /[a-zA-Z\s\d(\-,.'&:#)]\z/}


  def self.import(file)
    allowed_attributes = ['service']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      service = find_by_id(row["id"]) || new
      service.attributes = row.to_hash.slice(*row.to_hash.keys)
      service.save!
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
