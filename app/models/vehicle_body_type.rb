class VehicleBodyType < ApplicationRecord
  has_many :vehicle_mark_body_types
  has_many :vehicle_registrations

  validates :name_en, length: { maximum: 20 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :name_ua, length: { maximum: 20 }, presence: true,
                      uniqueness: { case_sensitive: false }
end
