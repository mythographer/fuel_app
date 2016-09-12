class FuelBrand < ApplicationRecord
  has_many :engines
  has_many :filling_station_checks

  belongs_to :fuel_type

  validates :name_en, length: { maximum: 10 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :name_ua, length: { maximum: 10 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :fuel_type, presence: true
end
