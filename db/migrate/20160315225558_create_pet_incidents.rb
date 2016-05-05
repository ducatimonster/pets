class CreatePetIncidents < ActiveRecord::Migration
  def change
    create_table :pet_incidents do |t|
      t.date :incident_date
      t.references :pet, index: true, foreign_key: true
      t.references :incident, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
