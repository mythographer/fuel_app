class FuelCard < ApplicationRecord
  has_many :fill_ups

  belongs_to :fuel_card_brand
  belongs_to :fuel_card_status

  validates :card_no, length: { maximum: 50 }, presence: true,
                      uniqueness: { scope: [:fuel_card_brand, :card_no],
                                    case_sensitive: false }
  validates :fuel_card_brand, presence: true
  validates :fuel_card_status, presence: true
  validates :notes, length: { maximum: 255 }, allow_nil: true

  def fuel_card_brand_name
    fuel_card_brand.try(:name)
  end
  
  def fuel_card_brand_name=(name)
    self.fuel_card_brand = FuelCardBrand.find_by(name: name) if name.present?  
  end
end
