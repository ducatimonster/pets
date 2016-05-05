class RemoveNoteDateFromNote < ActiveRecord::Migration
  def change
    remove_column :notes, :note_date, :date
  end
end
