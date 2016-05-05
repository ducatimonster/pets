class Note < ActiveRecord::Base
  belongs_to :note_type
  belongs_to :pet
  require 'roo'

  validates_presence_of :note_description, :note_importance, :note_type_id
  validates_length_of :note_description, :maximum => 500
  validates_length_of :note_importance, :maximum => 10
  validates :note_description, :format     => { :with => /[a-zA-Z\s\d(\-,.'&:#?)]\z/}

  NOTE_IMPORTANCE = ["High", "Medium", "Low"]



  def self.search(search)
    where("note_description LIKE ? " ,"%#{search}%")
  end

  def end_date
    Date.today
  end

  def begin_date

  end

  def self.import(file)
    allowed_attributes = ['note']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      note = find_by_id(row["id"]) || new
      note.attributes = row.to_hash.slice(*row.to_hash.keys)
      note.save!
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

  # scope :note_importance, -> (note_importance) {where note_importance: note_importance}
  # scope :description, -> (description) {where description: description}
  # scope :date_span, -> (date_span) {where(date_span: begin_date..end_date)}

end
