class Product < ApplicationRecord
  has_many :checks
  has_one :products_fuel_brands, dependent: :destroy

  validates :name_ua,
    length: { maximum: 255,
              too_long: "%{count} characters is the maximum allowed" },
    presence: true,
    uniqueness: { case_sensitive: false }
end
