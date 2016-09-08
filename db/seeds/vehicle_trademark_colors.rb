100.times do |n|
  name_en = "Color#{n + 1}"
  name_ua = "Колір#{n + 1}"
  VehicleTrademarkColor.create(name_en: name_en, name_ua: name_ua)
end
