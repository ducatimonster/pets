class CreatePetBreeds < ActiveRecord::Migration
  def change
    create_table :pet_breeds do |t|
      t.references :pet, index: true, foreign_key: true
      t.references :breed, index: true, foreign_key: true
      t.text :notes

      t.timestamps null: false
    end
  end
end
