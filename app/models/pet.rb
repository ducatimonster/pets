class Pet < ActiveRecord::Base
  belongs_to :client
  belongs_to :color
  require 'roo'

  has_many :pet_incidents, :dependent => :delete_all
  accepts_nested_attributes_for :pet_incidents, reject_if: :all_blank, :allow_destroy => true

  has_many :shot_records, :dependent => :delete_all
  accepts_nested_attributes_for :shot_records, :allow_destroy => true, reject_if: :all_blank

  has_many :pet_breeds, :dependent => :delete_all
  accepts_nested_attributes_for :pet_breeds, reject_if: :all_blank, :allow_destroy => true

  has_many :notes, :dependent => :delete_all
  accepts_nested_attributes_for :notes,reject_if: :all_blank, :allow_destroy => true

  has_many :pet_image_repos, :dependent => :delete_all
  has_many :pet_incidents, :dependent => :delete_all
  has_many :groomings, :dependent => :delete_all

  has_many :pet_image_repos, :dependent => :delete_all
  accepts_nested_attributes_for :pet_image_repos ,reject_if: :all_blank, :allow_destroy => true


  has_attached_file :profile_image, styles: {  medium: "300x300>", thumb: "150x150#", large: "600x600>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\Z/
  validates :pet_name, :pet_gender, :color_id, :client_id, presence: true
  validate :dob_cannot_be_in_future

  validates :pet_name, :format     => { :with => /[a-zA-Z\s]\z/}

  #lengths
  validates_length_of :pet_name, :maximum => 35
  validates_length_of :pet_markings, :maximum => 500



  PET_GENDERS = ["Male", "Female"]
  #@TODO: uncomment this after seed load
  validate :must_have_one_breed



  def pet_owner_name

    "#{self.pet_name} " + "-" + " #{self.client.client_first_name}" " #{self.client.client_last_name}"
  end

   def must_have_one_breed
     errors.add :base, "Pet must be of at least one breed" if pet_breeds_empty?
   end

  def pet_breeds_empty?
    pet_breeds.empty? or pet_breeds.all? {|b| b.marked_for_destruction? }
  end
def get_pet_breeds(pet_id)
  breeds = PetBreed.joins(:breed).where(pet_id: pet_id).pluck(:breed).join(", ")
end

  def dob_cannot_be_in_future
    if pet_dob.present? && pet_dob > Date.today
      errors.add(:pet_dob, "can't be in the future")
    end
  end

  def pet_age
    date = Date.today
    dob = self.pet_dob
    day_diff = date.day - dob.day
    month_diff = date.month - dob.month - (day_diff < 0 ? 1 : 0)
    year_diff = date.year - dob.year - (month_diff < 0 ? 1 : 0)

    if year_diff == 0
      month_diff = month_diff * (-1)
      age = "#{month_diff} months"
    elsif year_diff == 1
      age = "#{year_diff} year #{month_diff} months"
    else
           age = "#{year_diff} years #{month_diff} months"
    end

  end

  def pet_gender_short
    if self.pet_gender.casecmp('female') == 0
      "F"
    else
      "M"
    end
  end


  def pet_status
    # self.shot_expiration.to_s < Date.today.to_s
    if self.pet_status_inactive == true
      "Deceased"
    else
      "Alive"
    end
  end


  def disclosure_status
    # self.shot_expiration.to_s < Date.today.to_s
    if self.pet_disclosure == true
      "Can release pet information"
    else
      "Cannot release pet information"
    end
  end

  def spayed_neutered_status
    # self.shot_expiration.to_s < Date.today.to_s
    if self.is_spay_neutered == true
      "Yes"
    else
      "No"
    end
  end

  def note_count(pet_id)
    Pet.find(pet_id).notes.size
  end

  def image_count(pet_id)
    Pet.find(pet_id).pet_image_repos.size
  end

  def   valid_vaccination_count(pet_id)
    ShotRecord.where("pet_id = ? AND shot_expiration > ?", pet_id, Date.today).count
  end


def find_client_id

end

  def self.search(search)
    # where("pet_name LIKE ? or pet_markings LIKE ?" ,"%#{search}%", "%#{search}%")
    # where("pet_markings LIKE ?", "%#{search}%")

    # or client_first_name || " " || client_last_name like :search \
    # select('(client_first_name || ' ' || client_last_name) as \'full_name\', *')
        joins(:client)
        .where( "pet_name LIKE :search \
          or pet_dob LIKE :search \
          or (client_first_name ||  ' ' || client_last_name) like :search \
          or client_first_name like :search \
          or client_last_name like :search \
          or client_id LIKE :search \
          or pet_markings LIKE :search ", search: "%#{search}%").order('pet_name asc')


    # where ("content LIKE ?", "%#{search}%")
  end



  def self.import(file)
    allowed_attributes = ['pet']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      pet = find_by_id(row["id"]) || new
      pet.attributes = row.to_hash.slice(*row.to_hash.keys)
      pet.save!
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
