# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Fuel
require File.expand_path('../seeds/fuel_types', __FILE__)
require File.expand_path('../seeds/fuel_brands', __FILE__)

# Fuel cards
require File.expand_path('../seeds/fuel_card_brands.rb', __FILE__)
require File.expand_path('../seeds/fuel_cards.rb', __FILE__)

# Subjects
require File.expand_path('../seeds/subjects', __FILE__)

# Vehicles
require File.expand_path('../seeds/vehicle_categories', __FILE__)
require File.expand_path('../seeds/vehicle_groups', __FILE__)
require File.expand_path('../seeds/vehicle_body_types', __FILE__)
require File.expand_path('../seeds/vehicle_trademarks', __FILE__)
require File.expand_path('../seeds/vehicle_trademark_colors', __FILE__)
require File.expand_path('../seeds/vehicle_mark_body_types', __FILE__)
require File.expand_path('../seeds/vehicle_models', __FILE__)
require File.expand_path('../seeds/vehicle_bodyworks', __FILE__)
require File.expand_path('../seeds/gearboxes', __FILE__)
require File.expand_path('../seeds/engine_powers', __FILE__)
require File.expand_path('../seeds/engines', __FILE__)
require File.expand_path('../seeds/vehicle_trim_levels', __FILE__)
require File.expand_path('../seeds/vehicle_configurations', __FILE__)
require File.expand_path('../seeds/vehicle_statuses', __FILE__)
require File.expand_path('../seeds/fleets', __FILE__)
require File.expand_path('../seeds/cost_centres', __FILE__)
require File.expand_path('../seeds/vehicles', __FILE__)
require File.expand_path('../seeds/vehicle_registration_colors', __FILE__)
require File.expand_path('../seeds/vehicle_registrations', __FILE__)
require File.expand_path('../seeds/vehicle_inventories', __FILE__)

# Waybills and fuel checks
require File.expand_path('../seeds/waybills', __FILE__)
require File.expand_path('../seeds/fuel_checks', __FILE__)
