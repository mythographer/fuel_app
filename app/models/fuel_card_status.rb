class FuelCardStatus < ApplicationRecord
  has_many :fuel_cards

  validates :name_ua, presence: true,
    length: { maximum: 30,
              too_long: "%{count} characters is the maximum allowed" },
    uniqueness: { case_sensitive: false }
  validates :description,
    length: { maximum: 255,
              too_long: "%{count} characters is the maximum allowed" }
end
