class RemoveNotesFromPetBreed < ActiveRecord::Migration
  def change
    remove_column :pet_breeds, :notes, :text
  end
end
