class Color < ActiveRecord::Base
  has_many :pets
  require 'roo'

  validates :color_name, :format     =>  { :with => /[a-zA-Z\s]\z/}


  validates :color_name, presence: true
  validates_length_of :color_name, :maximum => 30

  def self.import(file)
    allowed_attributes = ['color']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      color = find_by_id(row["id"]) || new
      color.attributes = row.to_hash.slice(*row.to_hash.keys)
      color.save!
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
