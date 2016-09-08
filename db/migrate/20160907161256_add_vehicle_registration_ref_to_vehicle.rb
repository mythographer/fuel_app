class AddVehicleRegistrationRefToVehicle < ActiveRecord::Migration[5.0]
  def change
    add_reference :vehicles, :vehicle_registration, index: true, foreign_key: true
  end
end
