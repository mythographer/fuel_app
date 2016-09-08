waybills = Waybill.all
fuel_cards = FuelCard.all
fuel_brands = FuelBrand.all
unit_prices = [12.50, 13.49, 11.78, 21.99, 21.49, 18.99, 22.49]
waybills.each do |waybill|
  rand(1..30).times do |n|
    FuelCheck.create(
      check_no: Faker::Number.number(rand(10..20)),
      check_datetime: Faker::Time.between(waybill.initial_date, waybill.final_date),
      fuel_card: fuel_cards[rand(0...fuel_cards.size)],
      fuel_brand: fuel_brands[rand(0...fuel_brands.size)],
      quantity: rand(1.0..40.0).round(2),
      unit_price: unit_prices[rand(0...unit_prices.size)],
      total_vat: 1.0,
      waybill: waybill,
      mileage: nil,
      vehicle: waybill.vehicle,
      comment: rand(0..9) == 5 ? Faker::Lorem.sentence : nil
    )
  end
end
