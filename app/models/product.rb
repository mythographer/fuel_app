class Product < ApplicationRecord
  has_many :fill_ups
  has_one :products_fuel_brands, dependent: :destroy

  validates :name_ua, length: { maximum: 255 }, presence: true,
    uniqueness: { case_sensitive: false }
end
