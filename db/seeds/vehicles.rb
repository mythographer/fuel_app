fleets = Fleet.all
cost_centres = CostCentre.all
vehicle_configurations = VehicleConfiguration.all
tm_colors = VehicleTrademarkColor.all
statuses = VehicleStatus.all
100.times do |n|
  Vehicle.create(
    vin:  'ABC' + Faker::Number.number(14), # Faker::Vehicle.vin,
    vehicle_registration: nil,
    vehicle_configuration: vehicle_configurations[rand(0...vehicle_configurations.size)],
    vehicle_trademark_color: tm_colors[rand(0...tm_colors.size)],
    metallic: (rand(0..1) == 1),
    fleet: fleets[rand(0...fleets.size)],
    vehicle_status: statuses[rand(0...statuses.size)],
    cost_centre: cost_centres[rand(0...cost_centres.size)],
    vehicle_inventory_id: nil
  )
end
