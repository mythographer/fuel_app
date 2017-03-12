class FuelCardStatus < ApplicationRecord
  has_many :fuel_cards

  validates :name_ua, length: { maximum: 30 }, presence: true,
    uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 255 }
end
