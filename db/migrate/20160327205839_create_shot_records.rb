class CreateShotRecords < ActiveRecord::Migration
  def change
    create_table :shot_records do |t|
      t.references :vaccination, index: true, foreign_key: true
      t.date :shot_date
      t.date :shot_expiration
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
