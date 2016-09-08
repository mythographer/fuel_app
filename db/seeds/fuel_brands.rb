petrol = FuelType.find_by(name_en: 'petrol')
diesel = FuelType.find_by(name_en: 'diesel')
gas = FuelType.find_by(name_en: 'petrol/gas')

FuelBrand.create([
  { name_en: 'A95', name_ua: 'A95', fuel_type: petrol },
  { name_en: 'DF',  name_ua: 'ДП',  fuel_type: diesel },
  { name_en: 'A98', name_ua: 'A98', fuel_type: petrol },
  { name_en: 'A92', name_ua: 'A92', fuel_type: petrol },
  { name_en: 'A76', name_ua: 'A76', fuel_type: petrol },
  { name_en: 'P/G', name_ua: 'Б/Г', fuel_type: gas }
])
