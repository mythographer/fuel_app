class VehicleRegistrationColor < ApplicationRecord
  has_many :vehicle_registrations

  validates :name_ua, length: { maximum: 20 }, presence: true,
                      uniqueness: { case_sensitive: false }
end
