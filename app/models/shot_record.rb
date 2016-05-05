class ShotRecord < ActiveRecord::Base
  belongs_to :vaccination
  belongs_to :pet
  require 'roo'

  validates :vaccination_id, :shot_date, :shot_expiration, presence: true

  # @TODO: uncomment this after seeds file update
  validate :shot_date_cannot_be_in_the_future
  validate  :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if shot_expiration.present? && shot_expiration < Date.today
      errors.add(:shot_expiration, "can't be in the past")
    end
  end


  def shot_date_cannot_be_in_the_future
    if shot_date.present? && shot_date > Date.today
      errors.add(:shot_date, "can't be in the future")
    end
  end


  def self.pet_shot_records(pet_id)
    @shot_records = ShotRecord.joins(:vaccination).where(pet_id: pet_id).order("CASE vaccination_name
         WHEN 'Rabies' THEN 1
         ELSE 2 END ASC",shot_expiration: :desc)
  end

  def self.rabies_expiration(begin_date, end_date, sort_order)
    @records = ShotRecord.all.
        joins("INNER JOIN pets ON pets.id = shot_records.pet_id").
        where( "pets.pet_status_inactive = ? AND shot_records.shot_expiration BETWEEN ? AND ? ", false, begin_date, end_date).order("shot_expiration #{sort_order}")

  end

  def self.import(file)
    allowed_attributes = ['shot_record']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      shot_record = find_by_id(row["id"]) || new
      shot_record.attributes = row.to_hash.slice(*row.to_hash.keys)
      shot_record.save!
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


  def vaccination_current
    # self.shot_expiration.to_s < Date.today.to_s
    if self.shot_expiration.to_s < Date.today.to_s
      "Expired"
    else
      "Valid"
    end
  end
end
