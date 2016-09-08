class VehicleConfiguration < ApplicationRecord
  has_many :vehicles

  belongs_to :vehicle_bodywork
  belongs_to :vehicle_trim_level
  belongs_to :engine
  belongs_to :gearbox

  validates :vehicle_bodywork, uniqueness: { scope: [:vehicle_trim_level,
                                                     :engine, :gearbox,
                                                     :awd] },
                               presence: true
  validates :vehicle_trim_level, presence: true
  validates :engine, presence: true
  validates :gearbox, presence: true
  validates :awd, inclusion: { in: [true, false] }
  validates :fuel_capacity, numericality: { greater_than: 0 }, allow_nil: true
end
