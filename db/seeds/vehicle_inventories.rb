vehicles = Vehicle.all
vehicles.each do |vehicle|
  vehicle_inventory = VehicleInventory.create(
    vehicle: vehicle,
    date_in: vehicle.vehicle_registration.reg_date + rand(1..3).days, 
    date_out: nil
  )
  vehicle.vehicle_inventory = vehicle_inventory
  vehicle.save
end
