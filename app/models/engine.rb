class Engine < ApplicationRecord
  has_many :vehicle_configurations

  belongs_to :fuel_brand
  belongs_to :engine_power

  validates :capacity_l, numericality: { greater_than: 0.0 }, presence: true
  validates :capacity_cc, numericality: { greater_than: 0.0 },
                          uniqueness: { scope: [:capacity_l, :fuel_brand, :power,
                                                :engine_power] }, presence: true
  validates :fuel_brand, presence: true
  validates :power, numericality: { greater_than: 0 }, presence: true
  validates :engine_power, presence: true
  validates :cylinder_count, presence: true
end
