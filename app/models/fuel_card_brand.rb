class FuelCardBrand < ApplicationRecord
  has_many :fuel_cards

  validates :brand_name, presence: true,
    length: { maximum: 50,
              too_long: "%{count} characters is the maximum allowed" },
    uniqueness: { case_sensitive: false }
end
