class AddFlightNumberToCabRequests < ActiveRecord::Migration
  def up
    add_column :cab_requests, :flight_number, :string
  end

  def down
    remove_column :cab_requests, :flight_number
  end
end
