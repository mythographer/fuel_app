vehicles = Vehicle.all
colors = VehicleRegistrationColor.all
vro = Subject.first
vehicles.each do |vehicle|
  vehicle_registration = VehicleRegistration.create(
    doc_series: 'ABC',
    doc_no: Faker::Number.number(10),
    without_sn: false,
    reg_date: Faker::Date.between(1.years.ago, Date.today),
    vro_subject: vro,
    temporary: false,
    vin: vehicle.vin,
    reg_no: "AB#{Faker::Number.number(4)}CD",
    manufacture_year: 2015,
    vehicle_registration_color: colors[rand(0...colors.size)],
    total_weight: nil,
    engine_capacity_cc: nil,
    special_notes: nil,
    ext_reference: nil,
    vehicle: vehicle
  )
  vehicle.vehicle_registration = vehicle_registration
  vehicle.save
end
