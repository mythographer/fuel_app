class VehicleMarkBodyType < ApplicationRecord
  has_many :vehicle_bodyworks

  belongs_to :vehicle_trademark
  belongs_to :vehicle_body_type

  validates :name_en, length: { maximum: 20 },
                      presence: true,
                      uniqueness: { scope: :vehicle_trademark,
                                    case_sensitive: false }
  validates :name_ua, length: { maximum: 20 },
                      presence: true,
                      uniqueness: { scope: :vehicle_trademark,
                                    case_sensitive: false }
  validates :vehicle_trademark, presence: true
  validates :vehicle_body_type, presence: true
end
