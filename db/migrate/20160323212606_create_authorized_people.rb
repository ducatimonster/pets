class CreateAuthorizedPeople < ActiveRecord::Migration
  def change
    create_table :authorized_people do |t|
      t.string :full_name
      t.string :authorized_person_telephone
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
