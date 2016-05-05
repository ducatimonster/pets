class AuthorizedPerson < ActiveRecord::Base
  belongs_to :client

  validates_presence_of :full_name, :authorized_person_telephone
  validates :full_name, :format     => { :with => /[a-zA-Z\s]\z/}
end
