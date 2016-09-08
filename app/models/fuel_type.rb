class FuelType < ApplicationRecord
  has_many :fuel_brands

  validates :name_en, length: { maximum: 10 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :name_ua, length: { maximum: 10 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :abbr_name, length: { is: 1 }, presence: true,
                        uniqueness: { case_sensitive: false }
end
