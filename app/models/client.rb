class Client < ActiveRecord::Base
  has_many :pets, :dependent => :delete_all
  has_many :authorized_people, :dependent => :delete_all
  require 'roo'

  validates_presence_of :client_last_name,:client_first_name,
  :client_address, :client_telephone

  accepts_nested_attributes_for :authorized_people, :allow_destroy => true, reject_if: :all_blank

  # validates :client_telephone, :numericality => {:only_integer => true}
  validates :client_first_name, :client_last_name, :format     => { :with => /\A([^\d\W]|[-])*\z/}
  validates :client_address, :format     => { :with => /\A([a-zA-Z\s\d(\-,.)])*\z/}
  validate :email_validation

  #lengths
  validates_length_of :client_first_name, :maximum => 35
  validates_length_of :client_last_name, :maximum => 35
  validates_length_of :client_email, :maximum => 60
  validates_length_of :client_telephone, :maximum => 14
  validates_length_of :client_emergency_telephone, :maximum => 14
  validates_length_of :client_address, :maximum => 120

  # def client_name
  #  client.try(:client_first_name)
  # end
  #
  # def client=(client_name)
  #   self.client = Pet.find_by_pet_name(client_first_name) if client_name.present?
  # end


  def self.new_accounts(begin_date, end_date, sort_order)
    @accounts = Client.all.where(created_at: Date.parse(begin_date).beginning_of_day..Date.parse(end_date).beginning_of_day).order('created_at ' + sort_order)
  end

  def email_validation
    if client_email.present?
        validates_format_of :client_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    end
  end

  def client_current_status
    # self.shot_expiration.to_s < Date.today.to_s
    if self.client_status == true
      "Inactive"
    else
      "Active"
    end
  end

  def client_allow_status
    # self.shot_expiration.to_s < Date.today.to_s
    if self.allow_contact == true
      "Yes"
    else
      "No"
    end
  end


  def self.import(file)
    allowed_attributes = ['client']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      client = find_by_id(row["id"]) || new
      client.attributes = row.to_hash.slice(*row.to_hash.keys)
      client.save!
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


  def client_full_name
    "#{self.client_first_name} #{self.client_last_name}".split.map(&:capitalize).join(' ')
  end

  REFERRAL = ["Facebook", "Yelp", "Instagram", "Friends/Family", "Client", "Other Social Media"]

  def self.search(search)


    # select('(client_first_name || " " || client_last_name) as \'full_name\', *')
    # where("client_first_name LIKE :search OR " \
    # "client_last_name LIKE :search OR " \
    # "(client_first_name + ' ' + client_last_name) like :search OR " \
    # "client_email LIKE :search OR " \
    # "client_telephone LIKE :search OR " \
    # "client_emergency_telephone LIKE :search OR " \
    # "client_address LIKE :search " , search: "%#{search}%")

    where( "(client_first_name ||  ' ' || client_last_name) like :search \
          or client_last_name LIKE :search \
          or client_first_name LIKE :search \
          or client_email LIKE :search \
          or client_telephone LIKE :search \
          or client_emergency_telephone LIKE :search \
          or client_address LIKE :search ", search: "%#{search}%")



  end
  # scope :client_status, -> (client_status) {where client_status: client_status}

  def pet_count(client_id)
    Client.find(client_id).pets.size
  end


  def authorized_person_count(client_id)
    Client.find(client_id).authorized_people.size
  end
end
