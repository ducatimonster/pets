class Employee < ActiveRecord::Base
  has_many :employee_services
  require 'roo'


  validates_presence_of :employee_first_name, :employee_last_name, :emergency_contact_number

  #lengths
  validates_length_of :employee_first_name, :maximum => 35
  validates_length_of :employee_last_name, :maximum => 35
  validates_length_of :emergency_contact_number, :maximum => 14

  validates :employee_first_name, :employee_last_name, :format     => { :with => /\A([^\d\W]|[-])*\z/}

  def employee_full_name
    "#{self.employee_first_name} #{self.employee_last_name}".split.map(&:capitalize).join(' ')
  end

  def employee_current_status
    # self.shot_expiration.to_s < Date.today.to_s
    if self.employee_status == true
      "Inactive"
    else
      "Active"
    end
  end


  def employee_full_name
    "#{self.employee_first_name} #{self.employee_last_name}".split.map(&:capitalize).join(' ')
  end



  def self.import(file)
    allowed_attributes = ['employee']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      employee = find_by_id(row["id"]) || new
      employee.attributes = row.to_hash.slice(*row.to_hash.keys)
      employee.save!
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
