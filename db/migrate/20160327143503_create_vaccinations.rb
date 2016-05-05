class CreateVaccinations < ActiveRecord::Migration
  def change
    create_table :vaccinations do |t|
      t.string :vaccination_name

      t.timestamps null: false
    end
  end
end
