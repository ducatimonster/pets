class Grooming < ActiveRecord::Base
  belongs_to :pet
  require 'roo'

  has_many :grooming_services, :dependent => :delete_all
  accepts_nested_attributes_for :grooming_services, :allow_destroy => true, reject_if: :all_blank
  # # validates :date, presence: true
  # @TODO: uncomment this validator after seed load
  # validate :visit_pickup_date_cannot_be_past
  # validate :visit_pickup_time_cannot_be_past
  validate :pickup_date_time_cannot_be_past
  "pet_id IS NOT NULL"

  validate :must_have_one_service
  validates :date, presence: true

  def must_have_one_service
    errors.add :base, "Grooming visit must have at least one service." if grooming_services_empty?
  end

  def grooming_services_empty?
    grooming_services.empty? or grooming_services.all? {|b| b.marked_for_destruction? }
  end


  def self.pet_groomings(pet_id)
    @groomings = Grooming.where(pet_id: pet_id).order(date: :desc, created_at: :desc)
  end

  def self.visits(begin_date, end_date, sort_order)
    @visits = Grooming.all.where(date: begin_date..end_date).order('date ' + sort_order + ', arrival_time ' + sort_order)
  end

  def self.last_visit(days, sort_order)
    @visits= Grooming.all.joins("INNER JOIN pets ON pets.id = groomings.pet_id").where( "groomings.date <= date('now', '-" + days + " day') AND pets.pet_status_inactive = ? ", false).order('date ' + sort_order)
  end

  def days_since_last_visit
    date = self.date
    datetoday = Date.now
    day_diff = datetoday.day - date.day
    month_diff = datetoday.day - date.day - (day_diff < 0 ? 1 : 0)
    year_diff = datetoday.day - date.day - (month_diff < 0 ? 1 : 0)
  end

  # def visit_pickup_date_cannot_be_past
  #   if pickup_time.present? && pickup_time.strftime("%m/%d/%Y") < date.strftime("%m/%d/%Y")
  #     errors.add(:pickup_time, "can't be before arrival date")
  #   end
  # end

  # def visit_pickup_time_cannot_be_past
  #   if pickup_time.present? && pickup_time.strftime("%H:%M%") < arrival_time.strftime("%H:%M%")
  #     errors.add(:pickup_time, "can't be before arrival time")
  #   end
  # end

  def pickup_date_time_cannot_be_past
    arrival_date_time = (date.to_s + " " + arrival_time.to_s).to_datetime
    if pickup_time.present? && pickup_time.strftime('%Y%m%dT%H%M') < arrival_date_time.strftime('%Y%m%dT%H%M')
      errors.add(:pickup_time, "can't be before arrival time")
    end

  end

  def fleas_status
    # self.shot_expiration.to_s < Date.today.to_s
    if self.fleas_ticks == true
      "Yes"
    else
      "No"
    end
  end

  def matted_status
    # self.shot_expiration.to_s < Date.today.to_s
    if self.matted_tangled == true
      "Yes"
    else
      "No"
    end
  end


  def self.import(file)
    allowed_attributes = ['grooming']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      grooming = find_by_id(row["id"]) || new
      grooming.attributes = row.to_hash.slice(*row.to_hash.keys)
      grooming.save!
    end
  end
  #
  # def self.search(search)
  #
  #       .where( "pet_name LIKE :search \
  #         or pet_dob LIKE :search \
  #         or (client_first_name ||  ' ' || client_last_name) like :search \
  #         or client_first_name like :search \
  #         or client_last_name like :search \
  #         or client_id LIKE :search \
  #         or pet_markings LIKE :search ", begin_date: "%#{search}%")
  #
  # end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
