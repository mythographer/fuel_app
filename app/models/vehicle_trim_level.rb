# Trim levels are simply different versions of the same vehicle model
# # with different features and equipment.
class VehicleTrimLevel < ApplicationRecord
  has_many :vehicle_configurations

  belongs_to :vehicle_model

  validates :name_en, length: { maximum: 50 },
                      presence: true,
                      uniqueness: { scope: :vehicle_model,
                                    case_sensitive: false }
  validates :name_ua, length: { maximum: 50 },
                      presence: true,
                      uniqueness: { scope: :vehicle_model,
                                    case_sensitive: false }
  validates :vehicle_model, presence: true
end
