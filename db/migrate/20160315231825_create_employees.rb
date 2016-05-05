class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :employee_first_name
      t.string :employee_last_name
      t.string :emergency_contact_number
      t.boolean :employee_status

      t.timestamps null: false
    end
  end
end
