class AddVehicleTypeToCabRequests < ActiveRecord::Migration
  def up
    add_column :cab_requests, :vehicle_type, :string
  end

  def down
    remove_column :cab_requests, :vehicle_type
  end
end
