class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :client_first_name
      t.string :client_last_name
      t.string :client_email
      t.string :client_telephone
      t.string :client_emergency_telephone
      t.string :client_address
      t.boolean :client_status
      t.boolean :allow_contact
      t.string :referred

      t.timestamps null: false
    end
  end
end
