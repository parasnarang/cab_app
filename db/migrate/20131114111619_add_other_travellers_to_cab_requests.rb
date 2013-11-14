class AddOtherTravellersToCabRequests < ActiveRecord::Migration
  def change
    add_column :cab_requests, :other_travellers, :string
  end
end
