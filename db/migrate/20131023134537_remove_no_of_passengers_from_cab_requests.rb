class RemoveNoOfPassengersFromCabRequests < ActiveRecord::Migration
  def up
    remove_column :cab_requests, :no_of_passengers
  end

  def down
    add_column :cab_requests, :no_of_passengers, :integer
  end
end
