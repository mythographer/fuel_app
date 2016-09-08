class AddVehicleInventoryRefToVehicle < ActiveRecord::Migration[5.0]
  def change
    add_reference :vehicles, :vehicle_inventory, index: true, foreign_key: true
  end
end
