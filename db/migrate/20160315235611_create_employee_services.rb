class CreateEmployeeServices < ActiveRecord::Migration
  def change
    create_table :employee_services do |t|
      t.references :employee, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
