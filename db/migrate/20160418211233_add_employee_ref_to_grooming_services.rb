class AddEmployeeRefToGroomingServices < ActiveRecord::Migration
  def change
    add_reference :grooming_services, :employee, index: true, foreign_key: true
  end
end
