1000.times do |n|
  name_en = "Spec<#{'%04d' % (n + 1)}>"
  name_ua = "Компл<#{'%04d' % (n + 1)}>"
  vehicle_model_id = rand(4..503)
  VehicleTrimLevel.create(name_en: name_en, name_ua: name_ua, vehicle_model_id: vehicle_model_id)
end
