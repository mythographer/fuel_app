class FuelCardBrand < ApplicationRecord
  has_many :fuel_cards

  validates :name, length: { maximum: 50 }, presence: true,
    uniqueness: { case_sensitive: false }
end
