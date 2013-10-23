class RemoveFlightNumberFromCabRequests < ActiveRecord::Migration
  def up
    remove_column :cab_requests, :flight_number
  end

  def down
    add_column :cab_requests, :flight_number, :string
  end
end
