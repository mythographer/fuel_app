class VehicleCategory < ApplicationRecord
    has_many :vehicle_bodyworks

    validates :name_en, length: { maximum: 25 }, presence: true,
                        uniqueness: { case_sensitive: false }
    validates :name_ua, length: { maximum: 25 }, presence: true,
                        uniqueness: { case_sensitive: false }
end
