class VehicleTrademark < ApplicationRecord
  has_many :vehicle_models
  has_many :vehicle_mark_body_types

  validates :name_en, length: { maximum: 50 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :name_ua, length: { maximum: 50 }, presence: true,
                      uniqueness: { case_sensitive: false }
end
