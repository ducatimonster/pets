class CreateGroomingServices < ActiveRecord::Migration
  def change
    create_table :grooming_services do |t|
      t.references :service, index: true, foreign_key: true
      t.references :grooming, index: true, foreign_key: true
      t.text :notes

      t.timestamps null: false
    end
  end
end
