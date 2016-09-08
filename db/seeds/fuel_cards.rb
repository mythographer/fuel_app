card_brands = FuelCardBrand.all
100.times do |n|
  FuelCard.create(
    card_no: Faker::Number.number(10),
    fuel_card_brand: card_brands[rand(0...card_brands.size)],
    notes: rand(0..9) == 5 ? Faker::Lorem.sentence : nil
  )
end
