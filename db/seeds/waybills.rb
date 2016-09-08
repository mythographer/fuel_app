vehicles = Vehicle.all
1000.times do |n|
  initial_date = Faker::Date.between(30.days.ago, 5.days.ago)
  initial_mileage = Faker::Number.number(5)
  Waybill.create(
    doc_no: Faker::Number.number(10),
    initial_date: initial_date,
    final_date: initial_date + 5.days,
    vehicle: vehicles[rand(0...vehicles.size)],
    initial_mileage: initial_mileage.to_i,
    final_mileage: initial_mileage.to_i + rand(10..1000),
    initial_fuel: rand(10..40),
    final_fuel: rand(10..40),
    comment: rand(0..9) == 5 ? Faker::Lorem.sentence : nil
  )
end
