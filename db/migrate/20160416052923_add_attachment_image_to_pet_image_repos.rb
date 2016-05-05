class AddAttachmentImageToPetImageRepos < ActiveRecord::Migration
  def self.up
    change_table :pet_image_repos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :pet_image_repos, :image
  end
end
