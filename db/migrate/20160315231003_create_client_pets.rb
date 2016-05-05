class CreateClientPets < ActiveRecord::Migration
  def change
    create_table :client_pets do |t|
      t.references :client, index: true, foreign_key: true
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
