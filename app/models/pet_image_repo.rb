class PetImageRepo < ActiveRecord::Base
  belongs_to :pet

  has_attached_file :image, styles: {  medium: "300x300>", thumb: "150x150#", large: "600x600>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.pet_images(pet_id)
      @images = PetImageRepo.where(pet_id: pet_id).order(created_at: :desc)
  end
end


