class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.date :note_date
      t.text :note_description
      t.string :note_importance
      t.references :note_type, index: true, foreign_key: true
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
