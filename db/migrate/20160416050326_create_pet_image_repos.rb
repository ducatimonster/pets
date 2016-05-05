class CreatePetImageRepos < ActiveRecord::Migration
  def change
    create_table :pet_image_repos do |t|
      t.references :pet, index: true, foreign_key: true
      t.string :comment

      t.timestamps null: false
    end
  end
end
