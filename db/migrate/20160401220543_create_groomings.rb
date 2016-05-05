class CreateGroomings < ActiveRecord::Migration
  def change
    create_table :groomings do |t|
      t.date :date
      t.time :arrival_time
      t.datetime :pickup_time
      t.boolean :fleas_ticks
      t.boolean :matted_tangled
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
