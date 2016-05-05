class AddAttachmentProfileImageToPets < ActiveRecord::Migration
  def self.up
    change_table :pets do |t|
      t.attachment :profile_image
    end
  end

  def self.down
    remove_attachment :pets, :profile_image
  end

  def change
    add_attachment :pets, :profile_image
  end
end
