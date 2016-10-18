waybills = Waybill.all
fuel_cards = FuelCard.all
products = Product.all
unit_prices = [12.50, 13.49, 11.78, 21.99, 21.49, 18.99, 22.49]
waybills.each do |waybill|
  rand(1..30).times do |n|
    FillUp.create(
      check_no: Faker::Number.number(rand(10..20)),
      fill_up_datetime: Faker::Time.between(waybill.initial_date, waybill.final_date),
      fill_up_status_id: 1,
      fuel_card: fuel_cards[rand(0...fuel_cards.size)],
      filling_station_address: Faker::Address.street_address,
      product: products[rand(0...products.size)],
      quantity: rand(1.0..40.0).round(2),
      unit_price: unit_prices[rand(0...unit_prices.size)],
      total_vat: 1.0,
      waybill: waybill,
      odometer: nil,
      vehicle: waybill.vehicle,
      comment: rand(0..9) == 5 ? Faker::Lorem.sentence : nil
    )
  end
end
