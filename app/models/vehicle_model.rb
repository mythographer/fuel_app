class VehicleModel < ApplicationRecord
  has_many :vehicle_bodyworks
  has_many :vehicle_trim_levels

  belongs_to :vehicle_trademark
  belongs_to :vehicle_group

  validates :name_en, length: { maximum: 50 },
                      presence: true,
                      uniqueness: { scope: :vehicle_trademark,
                                    case_sensitive: false }
  validates :name_ua, length: { maximum: 50 },
                      presence: true,
                      uniqueness: { scope: :vehicle_trademark,
                                    case_sensitive: false }
  validates :vehicle_trademark, presence: true
  validates :wheel_count, numericality: { greater_than: 0 }, presence: true
end
