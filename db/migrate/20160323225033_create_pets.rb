class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :pet_name
      t.date :pet_dob
      t.string :pet_gender
      t.references :color, index: true, foreign_key: true
      t.text :pet_markings
      t.boolean :pet_status_inactive
      t.boolean :pet_disclosure
      t.boolean :is_spay_neutered
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
