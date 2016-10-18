class Vehicle < ApplicationRecord
  has_many :vehicle_registrations
  has_many :vehicle_inventories
  has_many :fill_ups
  has_many :waybills

  belongs_to :vehicle_configuration
  belongs_to :vehicle_trademark_color
  belongs_to :vehicle_status
  belongs_to :vehicle_registration, optional: true
  belongs_to :vehicle_inventory, optional: true
  belongs_to :fleet, optional: true
  belongs_to :cost_centre, optional: true

  validates :vin, vin: true, uniqueness: true, allow_nil: true
  validates :metallic, inclusion: { in: [true, false] }
  validates :vehicle_registration, uniqueness: true, allow_nil: true
  validates :vehicle_inventory, uniqueness: true, allow_nil: true
end
