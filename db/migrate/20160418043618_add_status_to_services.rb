class AddStatusToServices < ActiveRecord::Migration
  def change
    add_column :services, :service_status_inactive, :boolean
  end
end
