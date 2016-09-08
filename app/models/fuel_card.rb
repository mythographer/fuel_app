class FuelCard < ApplicationRecord
  has_many :fuel_checks

  belongs_to :fuel_card_brand

  validates :card_no, length: { maximum: 50 }, presence: true,
                      uniqueness: { scope: [:fuel_card_brand, :card_no],
                                    case_sensitive: false }
  validates :fuel_card_brand, presence: true
  validates :notes, length: { maximum: 255 }, allow_nil: true
end
