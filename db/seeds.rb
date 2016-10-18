# Create the seed data.

require 'benchmark'

SEEDS_DIR = '../seeds/'

def process_seeds(file_name)
  puts "-- seed(""#{file_name}"")"
  time = Benchmark.realtime do
    require File.expand_path(SEEDS_DIR + file_name + '.rb', __FILE__)
  end
  puts "   -> #{'%.4f' % time}s"
end

# Fuel
process_seeds 'fuel_types'
process_seeds 'fuel_brands'

# Fuel cards
process_seeds 'fuel_card_brands'
process_seeds 'fuel_card_statuses'
process_seeds 'fuel_cards'

# Subjects
process_seeds 'subjects'

# Vehicles
process_seeds'vehicle_categories'
process_seeds'vehicle_groups'
process_seeds'vehicle_body_types'
process_seeds'vehicle_trademarks'
process_seeds'vehicle_trademark_colors'
process_seeds'vehicle_mark_body_types'
process_seeds'vehicle_models'
process_seeds'vehicle_bodyworks'
process_seeds'gearboxes'
process_seeds'engine_powers'
process_seeds'engines'
process_seeds'vehicle_trim_levels'
process_seeds'vehicle_configurations'
process_seeds'vehicle_statuses'
process_seeds'fleets'
process_seeds'cost_centres'
process_seeds'vehicles'
process_seeds'vehicle_registration_colors'
process_seeds'vehicle_registrations'
process_seeds'vehicle_inventories'

# Waybills and Fill-Ups
process_seeds'waybills'
process_seeds'products'
process_seeds'fill_up_statuses'
process_seeds'fill_ups'
