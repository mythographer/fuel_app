prng = Random.new
800.times do |n|
  capacity_l = prng.rand(1.0..5.0).round(1)
  capacity_cc = (capacity_l * 1_000).to_i
  fuel_brand_id = rand(1..6)
  power = rand(100..200)
  engine_power_id = rand(1..2)
  cylinder_count = 4
  Engine.create(capacity_l: capacity_l,
                capacity_cc: capacity_cc,
                fuel_brand_id: fuel_brand_id,
                power: power,
                engine_power_id: engine_power_id,
                cylinder_count: cylinder_count)
end
