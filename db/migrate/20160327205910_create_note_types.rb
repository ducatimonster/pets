class CreateNoteTypes < ActiveRecord::Migration
  def change
    create_table :note_types do |t|
      t.string :note_type

      t.timestamps null: false
    end
  end
end
