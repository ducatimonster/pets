class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.date :incident_date
      t.string :incident_description

      t.timestamps null: false
    end
  end
end
