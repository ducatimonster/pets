class Incident < ActiveRecord::Base
  has_many :pet_incidents
  require 'roo'

  has_many :pet_incidents, :dependent => :delete_all
  accepts_nested_attributes_for :pet_incidents, reject_if: :all_blank, :allow_destroy => true

  validates_presence_of :incident_date, :incident_description
  validates_length_of :incident_description, :maximum => 500
  validates :incident_description, :format     => { :with => /[a-zA-Z\s\d(\-,.'&:#?)]\z/}
  validate :must_have_one_pet

  def self.pet_incidents(begin_date, end_date, sort_order)
    @incidents = Incident.all.where(incident_date: begin_date..end_date).order('created_at ' + sort_order)
  end

  def must_have_one_pet
    errors.add :base, "Incident must involve at least one pet" if pet_incidents_empty?
  end

  def pet_incidents_empty?
    pet_incidents.empty? or pet_incidents.all? {|b| b.marked_for_destruction? }
  end


  def get_pet_names(incident_id)
    pet_names = PetIncident.joins(:pet).where(incident_id: incident_id).pluck(:pet_name).join(", ").upcase
  end

  def self.import(file)
    allowed_attributes = ['incident']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      incident = find_by_id(row["id"]) || new
      incident.attributes = row.to_hash.slice(*row.to_hash.keys)
      incident.save!
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
